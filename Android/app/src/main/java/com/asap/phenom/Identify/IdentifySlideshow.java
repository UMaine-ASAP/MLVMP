package com.asap.phenom;


import android.content.Intent;
import android.graphics.Color;
import android.support.v4.view.ViewPager;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;

import android.util.Log;
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
 * This class governs the slideshow view used in the search tree and on the data pages
 */
public class IdentifySlideshow extends ActionBarActivity
{
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        getWindow().requestFeature(Window.FEATURE_ACTION_BAR_OVERLAY);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_identify_slideshow);
        getSupportActionBar().setDisplayShowCustomEnabled(true);
        getSupportActionBar().setCustomView(R.layout.action_bar);

        Intent intent = getIntent();                                                        //Set up action bar
        String category = intent.getStringExtra("title");
        TextView title = (TextView) findViewById(R.id.action_bar_text);
        title.setText(capitalizeFirst(category.toLowerCase()));
        ImageButton back = (ImageButton) findViewById(R.id.back_button);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
        back.setBackground(getResources().getDrawable(R.drawable.ic_close));
        getSupportActionBar().show();


        ArrayList<String> photos = intent.getStringArrayListExtra("photos");                            //Set up pager adapter with list of photos
        final IdentifySlideshowPagerAdapter adapter = new IdentifySlideshowPagerAdapter(this, photos);
        final ViewPager mViewPager = (ViewPager) findViewById(R.id.viewpager);
        mViewPager.setAdapter(adapter);

        LinearLayout dots = (LinearLayout) findViewById(R.id.dots);
        for (String photo : photos)                                               //Create photo indicators for photos
        {
            Button button = new Button(getBaseContext());
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(dpTopx(15), dpTopx(15));
            params.setMargins(dpTopx(5), dpTopx(1), dpTopx(5), dpTopx(1));
            button.setLayoutParams(params);

            if (photo.equals(photos.get(0)))                                    //Lightens dot that corresponds to first picture
                button.setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.light_dot));
            else
                button.setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.medium_dot));
            dots.addView(button);
        }
        mViewPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener()
        {
            int oldPosition = mViewPager.getCurrentItem();
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels)
            {}
            @Override
            public void onPageSelected(int position)                                    //When page is scrolled, modify page indicators
            {   LinearLayout dots = (LinearLayout) findViewById(R.id.dots);
                dots.getChildAt(oldPosition).setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.medium_dot));
                oldPosition = position;
                dots.getChildAt(position).setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.light_dot));
            }

            @Override
            public void onPageScrollStateChanged(int state)
            {}
        });
    }
    public int dpTopx(int dp)                                                               //Converts dp to pixels
    {
        return (int) (dp * getBaseContext().getResources().getDisplayMetrics().density);
    }

    public void toggleUI(View v)                                                    //Toggles Action Bar/ UI when screen is clicked (currently disabled)
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

    @Override
    public boolean onCreateOptionsMenu(Menu menu)                                   //Inflates menu
    {
        getMenuInflater().inflate(R.menu.menu_slideshow, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item)                             //Handles ActionBar clicks
    {
        int id = item.getItemId();

        if (id == R.id.action_home)
        {
            toHome();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }
    public void toHome()                                                            //Navigates to home page
    {
        Intent intent = new Intent(this, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
        overridePendingTransition(R.anim.fade_in,R.anim.fade_out);
        finish();
    }

    @Override
    public void onBackPressed()
    {
        super.onBackPressed();
        overridePendingTransition(R.anim.fade_in, R.anim.fade_out);
    }
    public String capitalizeFirst(String s)                                         //Capitalizes first letter in each word in string
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

}
