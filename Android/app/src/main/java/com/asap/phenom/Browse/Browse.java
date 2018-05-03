package com.asap.phenom;

import android.content.Intent;
import android.graphics.drawable.BitmapDrawable;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;

import android.view.View;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.TextView;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

/*  This class controls the Browse page of the app. BrowseListAdapter governs the ListView on this page

 */
public class Browse extends ActionBarActivity
{
    private ArrayList<Species> species;                                                     //Holds list of species that are displayed
    private BrowseListAdapter adapter;                                                      //Holds reference to list adapter
    //----------------------------------ACTIVITY LIFECYCLE METHODS -------------------------
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.browse);

        Intent intent = getIntent();                                            //Get list of species and name of category from Identify class
        species = intent.getParcelableArrayListExtra("species");
        String category = intent.getStringExtra("category");
                                                                            //Other Aquatic Curiosities has set order, otherwise sort alphabetically
        if (category.toLowerCase().equals("other aquatic curiosities"))
        {
            Collections.sort(species, new OrderComparator());
        }
        else {
            Collections.sort(species, new Comparator<Species>() {
                @Override
                public int compare(Species species1, Species species2) {

                    return species1.getName().compareTo(species2.getName());
                }
            });
        }
                         //Set up Action Bar
        getSupportActionBar().setDisplayShowCustomEnabled(true);
        getSupportActionBar().setCustomView(R.layout.action_bar);
        TextView title = (TextView) findViewById(R.id.action_bar_text);
        title.setText(capitalizeFirst(category.toLowerCase()));

        ImageButton back = (ImageButton) findViewById(R.id.back_button);            //Set up Back Button
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });

        final Object data = getLastCustomNonConfigurationInstance();                //Get saved list of loaded images if any (would come from orientation change)
        ArrayList<ArrayList<BitmapDrawable>> images;
        if (data == null)
            images = null;
        else
            images = (ArrayList<ArrayList<BitmapDrawable>>) data;

        adapter = new BrowseListAdapter(this, species, images);           //Set up ListView with adapter and list of species
        ListView listView = (ListView) findViewById(R.id.list);

        Thread updateThread;                                               //Set up thread that periodically updates listview images
        updateThread = new Thread(new update(adapter));
        updateThread.start();
        listView.setAdapter(adapter);

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)                                   // Inflate the menu; this adds items to the action bar if it is present.
    {
        getMenuInflater().inflate(R.menu.menu_browse, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item)                             // Handle action bar clicks
    {
        int id = item.getItemId();

        if (id == R.id.action_home)
        {
            toHome();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public Object onRetainCustomNonConfigurationInstance()                          //Saves list of loaded pictures in case of orientation change
    {   adapter.setRunThread(false);
        while (!adapter.isThreadDone())
        {
            try{Thread.sleep(10);}
            catch(InterruptedException e){}

        }
        final ArrayList<ArrayList<BitmapDrawable>> savedPics = adapter.getPictures();
        return savedPics;
    }

    //----------------------------------NAVIGATION METHODS -------------------------------
    public void toBrowseSlideshow(View v, int speciesIndex)                         //Goes to Slideshow view
    {
       Intent intent = new Intent(this,BrowseSlideshow.class);
       intent.putParcelableArrayListExtra("species",species);
       intent.putExtra("title", ((TextView) findViewById(R.id.action_bar_text)).getText().toString());
       intent.putExtra("speciesIndex", speciesIndex);

        String photoName = (String) v.getTag();
        intent.putExtra("photoName", photoName);                                    //Sends species list, species index in list, category title, and selected photo name

        startActivity(intent);
        overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
    }


    public void toHome()                                                            //Navigates to Home page
    {
        Intent intent = new Intent(this, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right);
        finish();
    }
    @Override
    public void onBackPressed()                                                     //Navigates back a page
    {
        super.onBackPressed();
        overridePendingTransition(R.anim.slide_in_top, R.anim.slide_out_bottom);
    }

    @Override
    public void onStop()                                                                //If activity is stopped, remove buttons
    {
        super.onStop();
        if (adapter.getThread2() != null);

    }

    @Override
    public void onRestart()                                                             //When page is navigated back to (from within app or elsewhere), buttons are refreshed
    {   super.onRestart();

    }
    //-------------------------------------HOUSEKEEPING METHODS ----------------------------
    public String capitalizeFirst(String s)                                         //Capitalizes first letter of each word in String
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
    //-------------------------------------LISTVIEW UPDATE THREAD ------------------------------
    public class update implements Runnable                                            //This thread updates the listview every 8th of a second in order to update pictures
    {

        private BrowseListAdapter a;
        public update(BrowseListAdapter b) {

            this.a = b;
        }

        public void run()                                                           //Narrows and expands matches and mismatches as needed
        {
            while (a.getThread2().isAlive())
            {
                Browse.this.runOnUiThread(new Runnable()
                {
                    @Override
                    public void run() {
                        a.notifyDataSetChanged();
                    }
                });
                try
                {   Thread.sleep(300);}
                catch (InterruptedException e)
                {}


            }
            Browse.this.runOnUiThread(new Runnable()
            {
                @Override
                public void run() {
                    a.notifyDataSetChanged();
                }
            });

        }


    }

}
