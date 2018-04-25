package com.asap.phenom;


import android.content.Context;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;

import android.support.v4.view.PagerAdapter;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;

import java.util.ArrayList;

/**
 * This class controls the view pager in the IdentifySlideshow class
 */
public class IdentifySlideshowPagerAdapter extends PagerAdapter
{
    ArrayList<String> pictures;                         //Array of pictures
    Context context;
    LayoutInflater inflater;


    public IdentifySlideshowPagerAdapter(Context context, ArrayList<String> pictures) {
        this.context = context;
        inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.pictures = pictures;
    }

    @Override
    public int getCount() {
        return pictures.size();
    }

    @Override
    public boolean isViewFromObject(View view, Object object)
    {
        return view == ((RelativeLayout) object);
    }

    @Override
    public Object instantiateItem(ViewGroup container, int position)
    {
        View itemView = inflater.inflate(R.layout.slideshow_image, container, false);               //Inflate imageView
        TouchImageView imageView = (TouchImageView) itemView.findViewById(R.id.imageView);
        int id = context.getResources().getIdentifier(pictures.get(position), "drawable", context.getPackageName());

        BitmapFactory.Options options = new BitmapFactory.Options();                                //Resize picture
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeResource(context.getResources(), id, options);
        options.inSampleSize = 2;
        options.inJustDecodeBounds = false;

        Bitmap i =  BitmapFactory.decodeResource(context.getResources(), id,options);               //Set image to imageview
        BitmapDrawable img = new BitmapDrawable(context.getResources(), i);
        imageView.setImageDrawable(img);
        imageView.setZoom(1);
        container.addView(itemView);
        return itemView;
    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        container.removeView((RelativeLayout) object);
    }
}
