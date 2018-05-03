package com.asap.phenom;


import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.ActivityInfo;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.preference.PreferenceManager;
import android.support.v4.view.ViewPager;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

/* Main page of app.  From here, user can navigate to About, Location, or Tree pages

 */

import java.util.ArrayList;


public class MainActivity extends ActionBarActivity
{
    SharedPreferences mreferences;
    final String tutorialShownPreferences = "tutorialShown";
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mreferences = PreferenceManager.getDefaultSharedPreferences(this);
        Boolean tutorialShown = mreferences.getBoolean(tutorialShownPreferences, false);
        if(!tutorialShown)
        {   TutorialPagerAdapter adapter = new TutorialPagerAdapter(this, true);           //Set up ListView with adapter and list of species
            ViewPager v  = (ViewPager) findViewById(R.id.viewpager);
            v.setAdapter(adapter);
            v.setVisibility(View.VISIBLE);
            findViewById(R.id.UI).setVisibility(View.VISIBLE);
            LinearLayout dots = (LinearLayout) findViewById(R.id.dots);
            for (int x=0; x < 5; x++)                                               //Create photo indicators for photos
            {
                Button button = new Button(getBaseContext());
                LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(dpTopx(15), dpTopx(15));
                params.setMargins(dpTopx(5), dpTopx(5), dpTopx(5), dpTopx(5));
                button.setLayoutParams(params);

                if (x==0)
                    button.setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.light_dot));
                else
                    button.setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.medium_dot_gray));
                dots.addView(button);
            }
            ((ViewPager) findViewById(R.id.viewpager)).setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
                int oldPosition = ((ViewPager) findViewById(R.id.viewpager)).getCurrentItem();

                @Override
                public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {
                }

                @Override
                public void onPageSelected(int position)                                    //When page is scrolled, modify page indicators
                {
                    LinearLayout dots = (LinearLayout) findViewById(R.id.dots);
                    dots.getChildAt(oldPosition).setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.medium_dot_gray));
                    oldPosition = position;
                    dots.getChildAt(position).setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.light_dot));
                }

                @Override
                public void onPageScrollStateChanged(int state) {
                }
            });

            setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        }
        else
        {
            findViewById(R.id.viewpager).setVisibility(View.GONE);
            findViewById(R.id.UI).setVisibility(View.GONE);
            setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_UNSPECIFIED);
        }

        getSupportActionBar().setDisplayShowCustomEnabled(true);                //Set up action bar
        getSupportActionBar().setCustomView(R.layout.action_bar);
        ImageButton back = (ImageButton) findViewById(R.id.back_button);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });

        ImageView i = (ImageView) findViewById(R.id.flora_image);
        updateBackground(i, "fragrant_waterlily5");
        i = (ImageView) findViewById(R.id.fauna_image);
        updateBackground(i,"bull_frog1");
        i = (ImageView) findViewById(R.id.pc_image);
        updateBackground(i,"lake_balls1");
        i = (ImageView) findViewById(R.id.location_image);
        updateBackground(i,"blue_water1");
    }


    public int dpTopx(int dp)                                                         //Converts pixels to dp
    {
        return (int) (dp * getBaseContext().getResources().getDisplayMetrics().density);
    }

    public void updateBackground(ImageView v, String photo)    //Updates background of button
    {
        Context context = v.getContext();
        int id = context.getResources().getIdentifier(photo, "drawable", context.getPackageName());
        int screenSize = context.getResources().getConfiguration().screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK;
        Bitmap b;
        int width;
        int height;
        int ivWidth;
        int ivHeight;

        if (screenSize == Configuration.SCREENLAYOUT_SIZE_LARGE || screenSize == Configuration.SCREENLAYOUT_SIZE_XLARGE) {
            width = dpTopx(200);
            ivWidth = dpTopx(450);
            ivHeight = dpTopx(320);

        }
        else
        {
            int dpi = getResources().getDisplayMetrics().densityDpi;
            float widthRatio = 480/dpi;
            width = dpTopx((int) widthRatio*99);
            ivWidth = dpTopx(300);
            ivHeight = dpTopx(210);

        }
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeResource(context.getResources(), id, options);
        float scale = 1;

        scale = (float)width/(float)options.outWidth;

        height = (int) (options.outHeight*scale);

        b = resizeImage(context.getResources(), id, width, height);
        BitmapDrawable img = new BitmapDrawable(context.getResources(),b);




        if (scale != 1)
        {
            v.getLayoutParams().height = (int)(((float)(height)/width)*ivWidth);
        }
        else
        {
            v.getLayoutParams().height = ivHeight;
        }



        v.setImageDrawable(img);
        v.setTag(id);
        v.setScaleType(ImageView.ScaleType.FIT_XY);

    }
    public static Bitmap resizeImage(Resources res, int resId, int width, int height)         //Used to convert image sizes
    {
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeResource(res, resId, options);

        options.inSampleSize = calculateInSampleSize(options, width, height);

        options.inJustDecodeBounds = false;
        return BitmapFactory.decodeResource(res, resId,options);
    }
    public static int calculateInSampleSize(BitmapFactory.Options options, int reqWidth, int reqHeight)     //Used to convert image sizes
    {
        // Raw height and width of image
        final int height = options.outHeight;
        final int width = options.outWidth;
        int inSampleSize = 1;

        if (height > reqHeight || width > reqWidth)
        {
            final int halfHeight = height / 2;
            final int halfWidth = width / 2;

            // Calculate the largest inSampleSize value that is a power of 2 and keeps both
            // height and width larger than the requested height and width.
            while ((halfHeight / inSampleSize) > reqHeight
                    && (halfWidth / inSampleSize) > reqWidth) {
                inSampleSize *= 2;
            }
        }

        return inSampleSize;
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu)                               // Inflate the menu; this adds items to the action bar if it is present.
    {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item)                         // Handle action bar item clicks here.
    {
        int id = item.getItemId();
        if (id == R.id.action_about)
        {
            toAbout();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    public void toIdentify(View view)                                           //Navigates to search tree if category is selected
    {
        Intent intent = new Intent(this,Identify.class);
        ArrayList<String> path = new ArrayList<String>();
        path.add(((Button)(((LinearLayout)(view)).getChildAt(1))).getText().toString().toLowerCase());
        intent.putStringArrayListExtra("path", path);                            //Send name of category clicked to Search tree
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_right,R.anim.slide_out_left);
    }

    public void toAbout()                                                       //Navigates to About page
    {   if ((findViewById(R.id.viewpager).getVisibility() == View.VISIBLE))
          return;
        else
        {
            Intent intent = new Intent(this, AboutActivity.class);
            startActivity(intent);
            overridePendingTransition(R.anim.slide_in_top, R.anim.slide_out_bottom);
        }

    }
    public void toLocation(View view)                                           //Navigates to Location page
    {
        Intent intent = new Intent(this,Location.class);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_right,R.anim.slide_out_left);

    }
    @Override
    public void onBackPressed()
    {   if ((findViewById(R.id.viewpager).getVisibility() == View.VISIBLE))
            return;
        super.onBackPressed();
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right);
    }
    public void finishTutorial(View v)
    {
        findViewById(R.id.viewpager).setVisibility(View.GONE);
        findViewById(R.id.UI).setVisibility(View.GONE);
        SharedPreferences.Editor editor = mreferences.edit();
        editor.putBoolean(tutorialShownPreferences, true);
        editor.commit();

    }
}
