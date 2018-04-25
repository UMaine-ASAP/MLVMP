package com.asap.phenom;

import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.support.v4.view.PagerAdapter;
import android.text.Html;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

/**
 * Created by mikescott on 8/6/15.
 */
public class TutorialPagerAdapter extends PagerAdapter
{

                             //Array of pictures
    Context context;
    LayoutInflater inflater;
    boolean fromMainPage;  //Tells if tutorial is being launched from main page or help page

    public TutorialPagerAdapter(Context context, boolean fromMainPage) {
        this.context = context;
        inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.fromMainPage = fromMainPage;
    }

    @Override
    public int getCount()
    {
        return 5;
    }

    @Override
    public boolean isViewFromObject(View view, Object object)
    {
        return view == ((LinearLayout) object);
    }

    @Override
    public Object instantiateItem(ViewGroup container, int position)
    {   boolean largeScreen = false;
        View itemView = null;
        int screenSize = context.getResources().getConfiguration().screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK;
        Bitmap b;
        if (screenSize == Configuration.SCREENLAYOUT_SIZE_LARGE || screenSize == Configuration.SCREENLAYOUT_SIZE_XLARGE)
            largeScreen = true;

        switch (position)
        {
            case 0:
                itemView = inflater.inflate(R.layout.tutorial_view1, container, false);//Inflate imageView
                break;
            case 1:
                itemView = inflater.inflate(R.layout.tutorial_view23, container, false);
                ImageView i = (ImageView) itemView.findViewById(R.id.image);
                if (largeScreen)
                    updateBackground(i, "bull_frog1", 200, 80);
                else
                    updateBackground(i, "bull_frog1", 99, 40);
                ((Button) itemView.findViewById(R.id.button)).setBackground(context.getResources().getDrawable(R.drawable.button));
                break;
            case 2:
                itemView = inflater.inflate(R.layout.tutorial_view23, container, false);
                ImageView h = (ImageView) itemView.findViewById(R.id.image);
                if (largeScreen)
                    updateBackground(h, "common_reed1", 200, 80);
                else
                    updateBackground(h, "common_reed1", 99, 40);
                ((Button) itemView.findViewById(R.id.button)).setBackground(context.getResources().getDrawable(R.drawable.invasive_button));
                ((Button) itemView.findViewById(R.id.button)).setText("Common Reed");
                String invasive = "Red indicates that a species is <b>" + "invasive" + "</b>.";
                ((TextView) itemView.findViewById(R.id.text)).setText(Html.fromHtml(invasive));
                break;
            case 3:
                itemView = inflater.inflate(R.layout.tutorial_view4, container, false);
                LinearLayout l = (LinearLayout) itemView.findViewById(R.id.photoBox);
                for (int x = 0; x < l.getChildCount(); x++)
                {   String name = "nostoc" + String.valueOf(x+1);
                   ImageView k =  ((ImageView) l.getChildAt(x));
                    if (largeScreen)
                        updateBackground(k, name, 50, 50);
                    else
                        updateBackground(k, name, 25, 25);
                }
                String browse = "Tapping \"Browse All\" will display categories as a collection of <b>" + "interactive" + "</b> photos.";
                ((TextView) itemView.findViewById(R.id.text)).setText(Html.fromHtml(browse));
                break;
            case 4:
                itemView = inflater.inflate(R.layout.tutorial_view5, container, false);
                if (!fromMainPage)
                {
                    ((TextView) itemView.findViewById(R.id.text)).setText("Tap 'Help' on the Info screen to see this tutorial again.");
                    ((Button) itemView.findViewById(R.id.finishButton)).setText("Return to Info");
                    ((Button) itemView.findViewById(R.id.finishButton)).setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            ((HelpActivity) context).onBackPressed();
                        }
                    });
                }
                break;
        }




        container.addView(itemView);
        return itemView;
    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        container.removeView((LinearLayout) object);
    }
    public int dpTopx(int dp)                                                         //Converts pixels to dp
    {
        return (int) (dp * context.getResources().getDisplayMetrics().density);
    }

    public void updateBackground(ImageView v, String photo, int width, int height)    //Updates background of button
    {

        int id = context.getResources().getIdentifier(photo, "drawable", context.getPackageName());
        Bitmap b;

        b = resizeImage(context.getResources(), id, dpTopx(width), dpTopx(height));
        BitmapDrawable img = new BitmapDrawable(context.getResources(),b);
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
















}
