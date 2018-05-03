package com.asap.phenom;

import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.BitmapDrawable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioGroup.LayoutParams;
import android.widget.TextView;

import com.asap.phenom.Core.MainActivity;
import com.asap.phenom.Identify.IdentifySlideshow;

import java.util.ArrayList;
import java.util.List;

/*  This class displays data for a species and links to a slideshow of pictures of it

 */
public class Data extends AppCompatActivity
{
    public ArrayList photos;                                                         //Array of pictures for species
    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_data);
        photos = new ArrayList<String>();

        Intent intent = getIntent();
        Species species = intent.getParcelableExtra("species");
        getSupportActionBar().setDisplayShowCustomEnabled(true);                    //Set up action bar and back button
        getSupportActionBar().setCustomView(R.layout.action_bar);
        TextView title = (TextView) findViewById(R.id.action_bar_text);
        title.setText(capitalizeFirst(species.getName().toLowerCase()));
        ImageButton back = (ImageButton) findViewById(R.id.back_button);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });

        ImageView v = (ImageView) findViewById(R.id.img);                           //Create photo that links to slideshow
        updateBackground(v,species.getFirstPhoto().substring(0, species.getFirstPhoto().indexOf(".")));
        List<String> pics = species.getPhotos();
        LinearLayout dots = (LinearLayout) findViewById(R.id.buttons);
        int x=0;
        for (String i : pics)                                                                   //Create photo indicators
        {
            photos.add(i.substring(0, i.indexOf(".")));
            Button button = new Button(this);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(dpTopx(15),dpTopx(15));
            params.setMargins(dpTopx(5), dpTopx(5), dpTopx(5), dpTopx(5));
            button.setLayoutParams(params);

            if (x == 0)
                button.setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.medium_dot));
            else
                button.setBackgroundDrawable(getApplicationContext().getResources().getDrawable(R.drawable.dark_dot));

            x++;
            dots.addView(button);
        }
        displayInfo(species);
    }
    public String capitalizeFirst(String s)
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
    public void updateBackground(ImageView v, String photo)                       //Updates background of button
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
            width = dpTopx(99);
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

        v.setScaleType(ImageView.ScaleType.FIT_XY);
    }
    public static Bitmap resizeImage(Resources res, int resId, int width, int height)      //Used to convert image sizes
    {
        BitmapFactory.Options options = new BitmapFactory.Options();
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeResource(res, resId, options);

        options.inSampleSize = calculateInSampleSize(options, width, height);

        options.inJustDecodeBounds = false;
        return BitmapFactory.decodeResource(res, resId, options);
    }
    public static int calculateInSampleSize(BitmapFactory.Options options, int reqWidth, int reqHeight)     //Used to convert image sizes
    {
        // Raw height and width of image
        final int height = options.outHeight;
        final int width = options.outWidth;
        int inSampleSize = 1;

        if (height > reqHeight || width > reqWidth) {

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

    public int dpTopx(int dp)                                                    //Converts dp to pixels
    {
        return (int) (dp * getResources().getDisplayMetrics().density);
    }
    public void displayInfo(Species s)                                          //Formats and displays text on page
    {

        TextView name = (TextView) findViewById(R.id.name_box);
        name.setText(s.getName());
        name.setGravity(Gravity.CENTER_HORIZONTAL);
        name.setTextSize(23);

        TextView sci_name = (TextView) findViewById(R.id.sci_name_box);
        sci_name.setTextSize(23);
        if (s.getScientific_name() != null)
            sci_name.setText(s.getScientific_name());
        else
            sci_name.setVisibility(View.GONE);
        List<String> information = s.getInformation();
        for (String section : information)
        {   String title = section.substring(0,section.indexOf('\n'));
            String facts = section.substring(section.indexOf('\n')+1);

            TextView titleBox = new TextView(this);                             //Format title box
            titleBox.setText(title); titleBox.setTextSize(21);
            titleBox.setTypeface(null, Typeface.BOLD);
            LayoutParams params = new LayoutParams(LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT);
            params.setMargins(dpTopx(18), dpTopx(18), dpTopx(18), 0);
            titleBox.setLayoutParams(params);
            titleBox.setTextColor(Color.parseColor("#002800"));

            TextView factBox = new TextView(this);                              //Format fact box
            factBox.setText(facts);
            factBox.setTextSize(19);
            params.setMargins(dpTopx(18), 0, dpTopx(18), 0);
            factBox.setLayoutParams(params);
            factBox.setTextColor(Color.parseColor("#002800"));

            LinearLayout l = (LinearLayout) findViewById(R.id.linlayout1);

            l.addView(titleBox);
            l.addView(factBox);
        }

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu)                           // Inflate the menu; this adds items to the action bar if it is present.
    {
        getMenuInflater().inflate(R.menu.menu_data, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item)          // Handle action bar item clicks here. The action bar will
    {
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_home) {
            toHome();
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    public void toHome()                                        //Navigate to home page
    {
        Intent intent = new Intent(this, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right);
        finish();
    }

    public void toSlideshow(View v)                             //Goes to slideshow of species' pictures
    {
        Intent intent = new Intent(this, IdentifySlideshow.class);
        TextView title = (TextView) findViewById(R.id.action_bar_text);
        String category = title.getText().toString();
        intent.putStringArrayListExtra("photos", photos);
        intent.putExtra("title", category);
        startActivity(intent);
        overridePendingTransition(R.anim.fade_in,R.anim.fade_out);
    }

    @Override
    public void onBackPressed()
    {   super.onBackPressed();
        overridePendingTransition(R.anim.slide_in_left, R.anim.slide_out_right);
    }

}
