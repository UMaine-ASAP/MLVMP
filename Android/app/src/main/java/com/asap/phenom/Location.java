package com.asap.phenom;

import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;


public class Location extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_location);
        getSupportActionBar().setDisplayShowCustomEnabled(true);
        getSupportActionBar().setCustomView(R.layout.action_bar);
        TextView title = (TextView) findViewById(R.id.action_bar_text);
        title.setText("Location");
        ImageView i = (ImageView) findViewById(R.id.shoreline_image);
        updateBackground(i, "yellowish_powder1");
        i = (ImageView) findViewById(R.id.surface_image);
        updateBackground(i, "alternate_flowered_watermilfoil5");
        i = (ImageView) findViewById(R.id.shallow_image);
        updateBackground(i, "common_bladderwort6");
        i = (ImageView) findViewById(R.id.deep_image);
        updateBackground(i, "landlocked_salmon1");
        i = (ImageView) findViewById(R.id.bottom_image);
        updateBackground(i, "freshwater_sponge4");
        ImageButton back = (ImageButton) findViewById(R.id.back_button);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_location, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_home)
        {
            toHome();
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
    public int dpTopx(int dp)                                                         //Converts pixels to dp
    {
        return (int) (dp * getBaseContext().getResources().getDisplayMetrics().density);
    }

    public void updateBackground(ImageView v, String photo)    //Updates background of button
    {
        Context context = getApplicationContext();
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
    public void toHome()
    {
        Intent intent = new Intent(this, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right);
        finish();
    }

    public void toIdentify(View v)                  //Pass category name and go to identify
    {   String category = "";


        if (v.getId() == R.id.button_surface)
            category = "surface";
        if (v.getId() == R.id.button_shallow)
            category = "shallow";
        if (v.getId() == R.id.button_deep)
            category = "deep";
        if (v.getId() == R.id.button_shoreline)
            category = "shoreline";
        if (v.getId() == R.id.button_bottom)
            category = "bottom";
        ArrayList<String> path = new ArrayList<>();
        path.add(category);

        Intent intent = new Intent(this,Identify.class);
        intent.putStringArrayListExtra("path", path);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_right, R.anim.slide_out_left);
    }

    @Override
    public void onBackPressed()
    {
        super.onBackPressed();
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right);
    }
}
