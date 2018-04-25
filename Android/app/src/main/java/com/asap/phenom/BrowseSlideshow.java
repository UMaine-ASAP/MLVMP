package com.asap.phenom;


import android.content.Intent;
import android.graphics.Color;
import android.support.v4.view.ViewPager;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;

import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;

import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import java.util.ArrayList;

/**
 * Created by Katrina on 6/15/15.
 *
 * This class governs the page for the Browse Slideshow of species pictures
 */
public class BrowseSlideshow extends ActionBarActivity
{   private BrowseSlideshowPagerAdapter adapter;                                                //Reference to Pager Adapter
    private ArrayList<Species> species;                                                         //List of species
    private ArrayList<String> photos;                                                           //List of all photo names from all species
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        getWindow().requestFeature(Window.FEATURE_ACTION_BAR_OVERLAY);                  //Set up Action Bar
        super.onCreate(savedInstanceState);
        setContentView(R.layout.slideshow);
        getSupportActionBar().setDisplayShowCustomEnabled(true);
        getSupportActionBar().setCustomView(R.layout.action_bar);

        Intent intent = getIntent();                                                    //Set title for action bar and back button
        String category = intent.getStringExtra("title");
        TextView title = (TextView) findViewById(R.id.action_bar_text);
        title.setText(capitalizeFirst(category.toLowerCase()));
        getSupportActionBar().show();
        ImageButton back = (ImageButton) findViewById(R.id.back_button);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
        back.setBackground(getResources().getDrawable(R.drawable.ic_close));

        species = intent.getParcelableArrayListExtra("species");                        //Get list of species, species and photo selected
        int speciesIndex = intent.getIntExtra("speciesIndex", 0);
        String photoName = intent.getStringExtra("photoName");
        if (savedInstanceState != null)
        {
            speciesIndex = savedInstanceState.getInt("current_species_index");
            photoName = species.get(speciesIndex).getPhotos().get(savedInstanceState.getInt("current_photo_index"));
        }

        photos = new ArrayList<String>();                                 //Create list of all photos for all species in category
        for (Species s : species)
            photos.addAll(s.getPhotos());
        int currentIndex;
        Species spec = species.get(speciesIndex);
        if (spec.getName().equals("Metaphyton"))
            currentIndex = photos.lastIndexOf(photoName);
        else
            currentIndex = photos.indexOf(photoName);
                                                                                        //Create Adapter and attach it to ViewPager
        adapter = new BrowseSlideshowPagerAdapter(this, photos, species, speciesIndex, photoName);
        final ViewPager mViewPager = (ViewPager) findViewById(R.id.viewpager);
        mViewPager.setAdapter(adapter);
        mViewPager.setCurrentItem(currentIndex);


        LinearLayout dots = (LinearLayout) findViewById(R.id.dots);
        TextView text = (TextView) findViewById(R.id.name);
        for (String photo : spec.getPhotos())                                               //Create photo indicators for photos
        {
            Button button = new Button(getBaseContext());
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(dpTopx(15), dpTopx(15));
            params.setMargins(dpTopx(5), dpTopx(1), dpTopx(5), dpTopx(1));
            button.setLayoutParams(params);

            if (photo.equals(photoName))
                button.setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.light_dot));
            else
                button.setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.medium_dot));
            dots.addView(button);
        }
        text.setText(spec.getName());
        mViewPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener()
        {
            int oldPosition = mViewPager.getCurrentItem();
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels)
            {}
            @Override
            public void onPageSelected(int position)                                    //When page is scrolled, modify current photo/species indexes accordingly
            {   int oldsIndex = adapter.getCurrentSpeciesIndex();

                if (position > oldPosition)//Moving right
                    adapter.setCurrentPhotoIndex(1);
                else
                if (position < oldPosition)//Moving left
                    adapter.setCurrentPhotoIndex(-1);

                oldPosition = position;
                LinearLayout dots = (LinearLayout) findViewById(R.id.dots);
                TextView text = (TextView) findViewById(R.id.name);
                int sIndex = adapter.getCurrentSpeciesIndex();
                int pIndex = adapter.getCurrentPhotoIndex();

                Species spec = species.get(sIndex);
                if (oldsIndex != sIndex)
                {
                    dots.removeAllViews();
                    for (String photo : spec.getPhotos())                                               //Create photo indicators for photos if new species is reached
                    {
                        Button button = new Button(getBaseContext());
                        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(dpTopx(15), dpTopx(15));
                        params.setMargins(dpTopx(5), dpTopx(5), dpTopx(5), dpTopx(5));
                        button.setLayoutParams(params);

                        if (photo.equals(photos.get(position)))
                            button.setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.light_dot));
                        else
                            button.setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.medium_dot));
                        dots.addView(button);
                    }
                    text.setText(spec.getName());
                }
                else
                    for (int i = 0; i < spec.getPhotos().size(); i++)                                               //Otherwise change existing indicators
                    {
                        if (i == pIndex)
                            dots.getChildAt(pIndex).setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.light_dot));
                        else
                            dots.getChildAt(i).setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.medium_dot));
                    }
                text.setText(spec.getName());


            }

            @Override
            public void onPageScrollStateChanged(int state)
            {}
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_browse_slideshow, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item)                                 // Handle action bar item clicks here
    {
        int id = item.getItemId();

        if (id == R.id.action_home) {
            toHome();
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onSaveInstanceState(Bundle savedInstanceState)                          //Save current photo /species indexes when activity is stopped
    {
        savedInstanceState.putInt("current_species_index", adapter.getCurrentSpeciesIndex());
        savedInstanceState.putInt("current_photo_index", adapter.getCurrentPhotoIndex());
        super.onSaveInstanceState(savedInstanceState);
    }

    public String capitalizeFirst(String s)                                             //Capitalizes first letter of each word in string
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


    public void toggleUI(View v)                                                        //Toggles UI when screen is clicked
    {
//        if (getSupportActionBar().isShowing())
//        {
//            getSupportActionBar().hide();
//            findViewById(R.id.UI).setVisibility(View.INVISIBLE);
//        }
//        else
//        {
//            getSupportActionBar().show();
//            findViewById(R.id.UI).setVisibility(View.VISIBLE);
//        }
    }

    public int dpTopx(int dp)                                                               //Converts dp to pixels
    {
        return (int) (dp * getBaseContext().getResources().getDisplayMetrics().density);
    }

    @Override
    public void onBackPressed()                                                         //Navigates back a page
    {
        super.onBackPressed();
        overridePendingTransition(R.anim.fade_in,R.anim.fade_out);
    }
    public void BrowsetoData(View v)                                                    //Navigates to Data page
    {   Species match = species.get(adapter.getCurrentSpeciesIndex());
        Intent intent = new Intent(this, Data.class);
        intent.putExtra("species", match);                                              //Send selected species to Data
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_right, R.anim.slide_out_left);
    }

    public void toHome()
    {
        Intent intent = new Intent(this, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
        overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
        finish();
    }


}
