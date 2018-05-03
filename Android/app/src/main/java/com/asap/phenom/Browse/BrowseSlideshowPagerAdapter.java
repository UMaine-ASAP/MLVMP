package com.asap.phenom;


import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;

import android.support.v4.view.PagerAdapter;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import java.util.ArrayList;

/**
 * Created by Katrina on 6/15/15.
 *
 * This class governs the ViewPager on the browse Slideshow
 */
public class BrowseSlideshowPagerAdapter extends PagerAdapter
{
    ArrayList<String> pictures;                                     //List of all pictures of all species in category
    Context context;                                                //Context for Browse Slideshow activity

    private ArrayList<Species> species;                                     //List of species in category
    private int currentSpeciesIndex;                                        //Index of current species in array
    private int currentPhotoIndex;                                          //Index of current photo in picture array


    public BrowseSlideshowPagerAdapter(Context context, ArrayList<String> pictures, ArrayList<Species> species, int currentSpeciesIndex, String photo) {
        this.context = context;
        this.pictures = pictures;
        this.species = species;
        this.currentSpeciesIndex = currentSpeciesIndex;
        this.currentPhotoIndex = species.get(currentSpeciesIndex).getPhotos().indexOf(photo);


    }
    public void setCurrentSpeciesIndex(int increment)               //Increment species Index
    {
        currentSpeciesIndex += increment;
    }

    public void setCurrentPhotoIndex(int increment)                 //Increment photo index
    {
        currentPhotoIndex += increment;
        if (currentPhotoIndex == species.get(currentSpeciesIndex).getPhotos().size()) {
            currentPhotoIndex = 0;
            setCurrentSpeciesIndex(1);
        }
        else
        if (currentPhotoIndex == -1)
        {
            setCurrentSpeciesIndex(-1);

            currentPhotoIndex =( (species.get(currentSpeciesIndex)).getPhotos()).size()-1;

        }
    }

    public int getCurrentSpeciesIndex()                             //Return species / photo index
    {
        return currentSpeciesIndex;
    }
    public int getCurrentPhotoIndex()
    {
        return currentPhotoIndex;
    }
    @Override
    public int getCount() {
        return pictures.size();
    }                                              //Returns number of photos in picture array

    @Override
    public boolean isViewFromObject(View view, Object object) {
        return view == ((RelativeLayout) object);
    }

    @Override
    public Object instantiateItem(ViewGroup container, int position)                        //Instantiate picture page in slideshow
    {   LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View itemView = inflater.inflate(R.layout.slideshow_image, container, false);
        ImageView imageView = (ImageView) itemView.findViewById(R.id.imageView);
        int id = context.getResources().getIdentifier(pictures.get(position).substring(0, pictures.get(position).indexOf(".")), "drawable", context.getPackageName());

        BitmapFactory.Options options = new BitmapFactory.Options();                        //Resize image
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeResource(context.getResources(), id, options);
        options.inSampleSize = 2;
        options.inJustDecodeBounds = false;

        Bitmap i =  BitmapFactory.decodeResource(context.getResources(), id,options);       //Set it to imageview

        imageView.setImageBitmap(i);

        container.addView(itemView);
        return itemView;
    }



    @Override
    public void destroyItem(ViewGroup container, int position, Object object)
    {
        container.removeView((RelativeLayout) object);

    }
}
