package com.asap.phenom.Identify;

import com.asap.phenom.*;
import com.asap.phenom.Core.MainActivity;
import com.asap.phenom.Browse.Browse;

import android.content.Context;
import android.content.Intent;
import android.content.res.AssetManager;
import android.os.Handler;
import android.support.v4.view.ViewPager;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ListView;

import android.widget.RelativeLayout;
import android.widget.TextView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Stack;



public class Identify extends AppCompatActivity
{
    protected volatile static ArrayList<String> path;                                   //List containing all currently selected category tags
    protected volatile boolean matchesFilled = false;                                   //Is true if the matches list has filled at least once
    protected volatile ArrayList<Species> matches;                                      //Lists containing phenomena that match / don't match the current list of tags selected
    protected volatile Stack<ArrayList<Species>> mismatches;
    protected volatile boolean stopThread = false;                                      //Variables that pause the thread or terminate it upon leaving/destroying the activity
    protected volatile boolean terminateThread = false;
    protected Thread thread2;                                                           //Reference to second thread
    protected static treeNode rootNode;                                                 //References to the root node of the tree and the current one
    protected static treeNode currentNode;
    boolean backAnimationPlaying = false;                                               //These variables are true when a forward or back animation is playing, they prevent multiple button presses
    boolean forwardAnimationPlaying = false;

    // ---------------ACTIVITY SETUP METHODS ------------------

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_identify);
        matches = new ArrayList<Species>();                                                         //Initialize match/mismatch lists
        mismatches = new Stack<ArrayList<Species>>();

        path = getIntent().getStringArrayListExtra("path");
        String previousCategory = path.get(path.size() - 1);
        thread2 = new Thread(new thread2());                                                //Thread2 will load all species to match list and start narrowing matches
        thread2.start();
        getSupportActionBar().setDisplayShowCustomEnabled(true);
        getSupportActionBar().setCustomView(R.layout.action_bar);
        TextView title = (TextView) findViewById(R.id.action_bar_text);
        ImageButton back = (ImageButton) findViewById(R.id.back_button);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
        title.setText(capitalizeFirst(previousCategory.toLowerCase()));

        try
        {
            JSONObject tree = new JSONObject(loadJSON("searchTree.json"));                      //Create tree of category names
            rootNode = createTree(null,tree,"phenomena");
        }
        catch (JSONException e)
        {}
        currentNode = rootNode;
        ArrayList<String> locations = new ArrayList<>();
        locations.add("shallow"); locations.add("deep"); locations.add("bottom"); locations.add("shoreline"); locations.add("surface");
        while (!matchesFilled)                                                              //Wait for species to be loaded and matches to be narrowed first time
            try{Thread.sleep(10);}
            catch (InterruptedException e){}

        if (!locations.contains(previousCategory))                                          //If not coming from location page, skip flora/fauna/physical curiosity selection
            currentNode = currentNode.getChild(previousCategory);
        else
            removeIrrelevent(currentNode);                                                  //If coming from location page, remove dead-end tree paths
        updateButtons("forward");

    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu)                                       // Inflate the menu; this adds items to the action bar if it is present.
    {   getMenuInflater().inflate(R.menu.menu_identify, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item)                                  // Handle action bar item clicks here
    {   int id = item.getItemId();
        if (id == R.id.action_home) {
            toHome();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }


    // -----------------TREE NAVIGATION / CREATION METHODS ---------------------

    public boolean removeIrrelevent(treeNode current)                                        //Recursively navigates tree and eliminates paths that yield no species (used for location trees)
    {
        ArrayList<treeNode> children = current.getChildren();
        ArrayList<treeNode> toRemove = new ArrayList<>();
        if (!(children == null))
        {
            for (treeNode child : children)
                if (removeIrrelevent(child))                                                    //Check each child recursively to see if node should be removed
                    toRemove.add(child);

            current.removeChildren(toRemove);                                                   //Remove all children that apply
        }

        for (Species m : matches)                                                               //Check if category is represented in matches
        {
            ArrayList<String> tags = m.getTags();
            if (tags.contains(current.getNodeName()))
                return false;
        }
        return true;                                                                            //If item is not represented, return true (should be removed)
    }


    public treeNode createTree(treeNode parent, JSONObject current, String currentName)       //Recursively creates tree of treeNodes for each tag; returns reference to root node
    {  treeNode t = null; String photo =  null;
        try
        {
            Iterator<String> k = current.keys();
            ArrayList<String> keys = new ArrayList<String>();
            ArrayList<treeNode> children = new ArrayList<treeNode>();

            while (k.hasNext())                                                             //Change iterator of keys into arraylist for easier manipulation
                keys.add(k.next());
            Collections.sort(keys);

            if (!currentName.equals("phenomena"))                                           //If name of current category is anything besides phenomena, set picture and remove it from keys
            {
                photo = current.getString("picture");
                keys.remove("picture");
            }
            t = new treeNode(parent, currentName, null, photo);                             //Create treeNode for category

            if (keys.isEmpty())
                children = null;
            for (String c : keys)                                                           //Add children nodes (if any)
                children.add(createTree(t, current.getJSONObject(c), c));

            t.setChildren(children);
        }

        catch (JSONException e)
        {  }
        return t;                                                                           //Return completed node
    }

    public void advanceSearch(View view)                                                     //Navigate forward in search
    {   if (!forwardAnimationPlaying)
    {
        String selectedText = ((Button) ((LinearLayout)view).getChildAt(1)).getText().toString().toLowerCase();

        currentNode = currentNode.getChild(selectedText);                                   //Change current node to one just chosen
        path.add(selectedText);


        TextView title = (TextView) findViewById(R.id.action_bar_text);
        String tag = currentNode.getNodeName().toLowerCase();

        title.setText(capitalizeFirst(tag));            //Sets action bar to node title

        removeButtons("forward");
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                updateButtons("forward");
            }
        }, 350);//Removes buttons and adds new ones

        this.forwardAnimationPlaying = true;
        //This delay prevents back from being pressed while forward animation plays
        new Handler().postDelayed(new Runnable()  {@Override public void run() {forwardAnimationPlaying = false;}}, 800);




    }
    }

    public void regressSearch()                                                         //Brings user back in search tree
    {
        TextView title = (TextView) findViewById(R.id.action_bar_text);
        String tag;
        if (currentNode.getNodeName().equals("phenomena"))
            tag = capitalizeFirst(path.get(0).toLowerCase());
        else
            tag = capitalizeFirst(currentNode.getNodeName().toLowerCase());    //Set action bar to location name or current node name
        title.setText(tag);

        removeButtons("back");                                                      //Change buttons and play back animation
        new Handler().postDelayed(new Runnable() {@Override public void run() {updateButtons("back");}}, 350);//Removes buttons and adds new ones
    }

    public void removeButtons(String direction)                                                         //Removes old buttons from page
    {
        RelativeLayout layout = (RelativeLayout) findViewById(R.id.linlayout1);
        final ListView list = (ListView) layout.getChildAt(0);

        Animation slide;
        if (!direction.equals("none"))
        {
            if (direction.equals("forward"))                                            //Set animation to play when buttons are removed
                slide = AnimationUtils.loadAnimation(this, R.anim.slide_out_left);
            else
                slide = AnimationUtils.loadAnimation(this, R.anim.slide_out_right);

            list.startAnimation(slide);
                                                                                    //Prevents list from being removed while animating
            list.postDelayed(new Runnable() {@Override public void run() {((RelativeLayout) list.getParent()).removeView(list);}}, 320);
        }
        else
            ((RelativeLayout) list.getParent()).removeView(list);
    }

    public void updateButtons(String direction)                                              //Updates category / species buttons
    {   LayoutInflater inflater = (LayoutInflater)getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        final ListView listview = new ListView(this);
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        params.gravity=Gravity.CENTER_HORIZONTAL;

        listview.setLayoutParams(params);
        listview.setFocusable(false);
        listview.setFocusableInTouchMode(true);
        listview.setClickable(false);
        listview.setClipToPadding(false);

        if (currentNode.isLeaf())                                                           //If node is leaf, create species buttons
        {   IdentifySpeciesAdapter adapter = new IdentifySpeciesAdapter(this, matches);
            listview.setAdapter(adapter);

        }
        else                                                                                //Otherwise create category buttons
        {
            ArrayList<treeNode> children = currentNode.getChildren();
            IdentifyCategoryAdapter adapter = new IdentifyCategoryAdapter(this, children);
            listview.setAdapter(adapter);
        }

                                                                                             //Attach browse button to bottom of list
        LinearLayout b = (LinearLayout) inflater.inflate(R.layout.browsebutton, null);
        listview.addFooterView(b);
        listview.setDivider(null);
        listview.setDividerHeight(dpTopx(18));
        Animation slide = null;
        if (!direction.equals("restart"))
        {
            if (direction.equals("forward"))
                slide = AnimationUtils.loadAnimation(this, R.anim.slide_in_right);
            else
                slide = AnimationUtils.loadAnimation(this, R.anim.slide_in_left);
        }
        RelativeLayout parent = (RelativeLayout) findViewById(R.id.linlayout1);

        parent.addView(listview);
        if (!direction.equals("restart"))
        {
            slide.setDuration(600);
            listview.startAnimation(slide);

        }
        String tag = currentNode.getNodeName().toLowerCase();
        if (tag.equals("filamentous mat-forming algae") || tag.equals("cotton-candy or cloud-like algae") || tag.equals("algae that color the water"))
        {


            NotePagerAdapter adapter = new NotePagerAdapter(this, true);           //Set up ListView with adapter and list of species
            ViewPager v = (ViewPager) findViewById(R.id.viewpager);
            adapter.tag = tag;
            v.setAdapter(adapter);
            if (direction.equals("restart"))
                v.setVisibility(View.GONE);
            else
                v.setVisibility(View.VISIBLE);


            ((ViewPager) findViewById(R.id.viewpager)).setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
                int oldPosition = ((ViewPager) findViewById(R.id.viewpager)).getCurrentItem();

                @Override
                public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {
                }

                @Override
                public void onPageSelected(int position)                                    //When page is scrolled, modify page indicators
                {
                    if (position == 1) {
                        findViewById(R.id.viewpager).postDelayed(new Runnable() {
                            @Override
                            public void run() {
                                findViewById(R.id.viewpager).setVisibility(View.GONE);
                            }
                        }, 320);
                    }
                }

                @Override
                public void onPageScrollStateChanged(int state) {
                }
            });
        }
        //Attach list of buttons to layout
    }



    //------------------- ACTIVITY LIFECYCLE METHODS / INTER-ACTIVITY NAVIGATION ------

    @Override
    public void onStop()                                                                //If activity is stopped, remove buttons
    {
        super.onStop();
        removeButtons("none");
        stopThread = true;
    }
    @Override
    public void onDestroy()
    {
        super.onDestroy();
        terminateThread = true;
    }

    @Override
    public void onRestart()                                                             //When page is navigated back to (from within app or elsewhere), buttons are refreshed
    {   super.onRestart();
        updateButtons("restart");
        stopThread = false;
    }

    @Override
    public void onBackPressed()                                                         //If back is pressed, this method navigates back in tree or to home page
    {
        if (!backAnimationPlaying && !forwardAnimationPlaying)                          //Back only functions if no animation is playing (prevents app from crashing)
        {   findViewById(R.id.viewpager).setVisibility(View.GONE);
            if (currentNode.getNodeName().equals("phenomena"))                              //If node is phenomena, navigates to location page
            {   super.onBackPressed();
                overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right);
                finish();
            }
            else
            {   currentNode = currentNode.getParent();                                      //Make current node parent of previous current node
                path.remove(path.size() - 1);

                if (currentNode.getNodeName().equals("phenomena") && (path.size() == 0))    //If back was pressed from top level page, back brings user to home page
                {   super.onBackPressed();
                    overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right);
                    finish();
                }
                else
                    regressSearch();
            }
        }

        this.backAnimationPlaying = true;
                                                                                            //This delay prevents multiple back presses too close to each other
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                backAnimationPlaying = false;
            }
        }, 600);
    }

    public void toData(View view)                                                       //Navigates to data view when species is selected
    {
        Species match = null;

        for (Species s : matches)
            if ((s.getName().toLowerCase()).equals(((Button) ((LinearLayout)view).getChildAt(1)).getText().toString().toLowerCase()))
                match = s;

        Intent intent = new Intent(this, Data.class);
        intent.putExtra("species", match);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_right, R.anim.slide_out_left);
    }

    public void toHome()                                                                //Brings user to home page
    {
        Intent intent = new Intent(this, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right);
        finish();
    }

    public void toBrowse(View v)                                                        //Sends list of matches to browse function
    {
        Intent intent = new Intent(this, Browse.class);
        intent.putParcelableArrayListExtra("species", matches);
        intent.putExtra("category", currentNode.getNodeName());

        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_bottom, R.anim.slide_out_top);
    }


    //------------------ HOUSEKEEPING METHODS ----------------------------------

    public String capitalizeFirst(String s)                                            //Takes a string and returns it with the first letter of each word capitalized
    {
        String[] words = s.split(" ");
        String newPhrase = "";
        for (String string : words)
        {
            String letter = string.substring(0,1).toUpperCase();
            if (string.length() > 1)
                letter = letter + string.substring(1);
            newPhrase += letter + " ";
        }
        return newPhrase.trim();
    }

    public String loadJSON(String file)                                                 //Takes json file name and returns path necessary to open it
    {
        String json;
        try
        {
            InputStream is = getAssets().open(file);
            int size = is.available();
            byte[] buffer = new byte[size];
            is.read(buffer);
            is.close();
            json = new String(buffer, "UTF-8");
        }
        catch (IOException e)
        {
            e.printStackTrace();
            return null;
        }
        return json;
    }

    public int dpTopx(int dp)                                                               //Converts dp to pixels
    {
        return (int) (dp * getBaseContext().getResources().getDisplayMetrics().density);
    }
    //--------------------SECOND THREAD CLASS --------------------------------

    public class thread2 implements Runnable                                            //Second thread loads species JSON files and sorts matches / mismatches
    {
        public thread2()
        {
        }
        public void run()                                                           //Narrows and expands matches and mismatches continuously
        {
            int pathSize = path.size();
            int prevpathSize = 0;
            loadAll();                                                              //Loads all species into matches
            while (!terminateThread)                                                //Thread finishes if tree activity is destroyed
            {
                while (!stopThread && !terminateThread)                             //If thread is not stopped or terminated, it continuously narrows and widens matches as needed
                {
                    pathSize = path.size();
                    if (pathSize > prevpathSize)
                        narrowSearch();
                    matchesFilled = true;                                           //Indicates that species have been loaded and narrowed at least once
                    if (pathSize < prevpathSize)
                        expandSearch();
                    prevpathSize = pathSize;
                    try {Thread.sleep(5);}
                    catch (InterruptedException e) {}
                }
                while (stopThread && !terminateThread)                              //If activity is just stopped, thread stops sorting and checks every second to see if it should start again
                    try {Thread.sleep(1000);}
                    catch (InterruptedException e) {}

            }

        }
        public void loadAll()                                                       //Loads all species files into match list
        {
            AssetManager a = getAssets();
            try
            {
                String[] l = a.list("species");
                for (String s : l)
                {   try
                    {
                        JSONObject species = new JSONObject(loadJSON("species/"+s));
                        String name = species.getString("name");
                        int invasive = 0;
                        JSONArray pictures= species.getJSONArray("pictures");

                        String sci_name = null;
                        if (species.has("scientific name"))
                            sci_name = species.get("scientific name").toString();
                        List<String> pics = new ArrayList<String>();
                        for (int x=0; x < pictures.length(); x++)
                            pics.add(pictures.getString(x));

                        JSONObject information = species.getJSONObject("information");  //Parse information in species JSON file
                        List<String> info = new ArrayList<String>();
                        Iterator<String> keys = information.keys();
                        int x = 0;

                        while (keys.hasNext())
                        {   int y=0;
                            String category = keys.next();
                            if (category.toLowerCase().trim().equals("invasive"))
                                invasive = 1;


                            JSONArray c = information.getJSONArray(category);
                            for (y=0; y<c.length(); y++)
                                category += "\n" + "\t- "+c.getString(y) + "\n";
                            info.add(category + "\n");
                            x++;
                        }

                        JSONArray obj = species.getJSONArray("tags");
                        ArrayList<String> tags  = new ArrayList<String>();
                        for (x = 0; x < obj.length(); x++)
                            tags.add(obj.getString(x));

                        matches.add(new Species(name,sci_name, tags, info, pics, invasive));
                    }
                    catch (JSONException e)
                    {}
                }
            }
            catch (IOException e)
            {}
        }

        public void narrowSearch()                                            //Narrows matches by comparing current match tags to tags selected by user
        {
            ArrayList<Species> clashes = new ArrayList<Species>();

            for (Species s : matches)
            {
                ArrayList<String> tags = s.getTags();
                String tag = path.get(path.size()-1);                         //If a tag in list was selected that doesn't apply, this species is added to clash list
                if (!tags.contains(tag))
                    clashes.add(s);
            }
            if (clashes.size() > 0)                                             //List of clashing species is added to mismatch stack and removed from matches
            {
                mismatches.push(clashes);
                matches.removeAll(clashes);
                if (path.get(path.size()-1).equals("other aquatic curiosities"))
                {

                    Collections.sort(matches, new OrderComparator());
                }
            }
        }

        public void expandSearch()                              //Re-inserts mismatches into match pool (this would be utilized if user navigated backwards in tree)
        {
            if (mismatches.size() != 0)
            {   Species potentialAdd = mismatches.peek().get(0);//Only check first species because every mismatch list contains species who were eliminated on same tag

                ArrayList<String> tags = potentialAdd.getTags();
                String lastTag = "";
                if (path.size() != 0)
                     lastTag = path.get(path.size()-1);

                if (tags.contains(lastTag))
                    matches.addAll(mismatches.pop());
            }
        }
    }
}
