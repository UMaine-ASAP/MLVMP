package com.asap.phenom.Browse;

import com.asap.phenom.*;

import android.content.Context;

import android.content.res.Configuration;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.BitmapDrawable;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;

import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;


/**
 * Created by Katrina on 6/17/15.
 *
 * This class governs the listview of species on the Browse page.
 */
public class BrowseListAdapter extends ArrayAdapter<Species> {
    ArrayList<ArrayList<BitmapDrawable>> pictures;                                      //References list of lists of loaded phenomena pictures
    private Thread thread2;                                                             //References second thread that loads pictures
    private boolean runThread = true;
    private boolean threadDone = false;
    //------------------BASIC  ADAPTER METHODS + METHODS TO ACCESS VARIABLES ----
    public BrowseListAdapter(Context context, ArrayList<Species> species, ArrayList<ArrayList<BitmapDrawable>> pics)
    {
        super(context, 0, species);
        if (pics == null)                                                               //Instantiate picture list if none have been saved for orientation change
            pictures = new ArrayList<>();
        else
            pictures = pics;                                                            //Otherwise set them to saved list
        thread2 = new Thread(new loadPictures(species));                                //Start loading up pictures that are still needed
        thread2.start();

    }
    public  Thread getThread2()                                                         //Returns reference to thread2 (used in Browse to see if list needs to be updated)
    {
        return thread2;
    }
    public ArrayList<ArrayList<BitmapDrawable>> getPictures()                           //Returns array of pictures (used in Browse to save array in case of orientation change)
    {
        return pictures;
    }
    @Override
    public View getView(final int position, View convertView, ViewGroup parent)         //Get new view to display in list when scrolled
    {
        Species s = getItem(position);

        if (convertView == null)                                                         //If not recycling a view, inflate new browse section
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.browsesection, parent, false);

        TableLayout table = (TableLayout) convertView.findViewById(R.id.table);         //Get reference to picture table and clear it if necessary
        if (table.getChildCount() != 0)
            table.removeAllViews();



        if ((pictures.size() >= position+1))                                                                           //Otherwise update the pictures
        {
            ArrayList<BitmapDrawable> photos = pictures.get(position);
            List<String> photoNames = s.getPhotos();
            int i = 0;
            int rowSize = 5;
            if (getContext().getResources().getConfiguration().orientation == Configuration.ORIENTATION_LANDSCAPE)  //If screen orientation is portrait, row of pictures is 5 pictures long, otherwise it's 9.
                rowSize = 9;

            while (i < photos.size())
            {
                TableRow row1 = new TableRow(getContext());
                for (int y = 0; y < rowSize; y++)                                                 //Make row of predetermined size
                {
                    if (i >= photos.size())
                        break;
                    ImageView img1 = (ImageView) LayoutInflater.from(getContext()).inflate(R.layout.browseimage, row1, false);
                    img1.setBackground(photos.get(i));

                    img1.setTag(photoNames.get(i));                                             //Set tag of photo name
                    img1.setOnClickListener(new View.OnClickListener()                      //When photo is clicked, it navigates user to Browse Slideshow
                    {
                        @Override
                        public void onClick(View v) {((Browse) getContext()).toBrowseSlideshow(v, position);}
                    });
                    row1.addView(img1);
                    i++;
                }
                table.addView(row1);
            }


        }
        TextView categoryName = (TextView) convertView.findViewById(R.id.categoryTitle);//Make title name of species

        if (s.isInvasive())                                                             //Set name to red if invasive
        {
            categoryName.setText(s.getName() + "   (Invasive)");
            categoryName.setTextColor(Color.parseColor("#990000"));
        }
        else
        {
            categoryName.setText(s.getName());
            categoryName.setTextColor(getContext().getResources().getColor(R.color.dark_brown));
        }

        return convertView;
    }
    public void setRunThread(boolean value)
    {
        runThread = value;
    }
    public boolean isThreadDone()
    {
        return threadDone;
    }
    //-------------------------------------PICTURE RESIZING METHODS ---------------
    public int dpTopx(int dp)                                                           //Converts dp to pixels
    {
        return (int) (dp * getContext().getResources().getDisplayMetrics().density);
    }
    public BitmapDrawable updateBackground(String photo)                             //Updates background of button with resized version
    {
        Context context = getContext();
        int id = context.getResources().getIdentifier(photo, "drawable", context.getPackageName());
        int screenSize = context.getResources().getConfiguration().screenLayout & Configuration.SCREENLAYOUT_SIZE_MASK;
        Bitmap b;
        if (screenSize == Configuration.SCREENLAYOUT_SIZE_LARGE || screenSize == Configuration.SCREENLAYOUT_SIZE_XLARGE)
            b = resizeImage(context.getResources(), id, dpTopx(40), dpTopx(40));    //Size of image based on device size
        else {
            int dpi = context.getResources().getDisplayMetrics().densityDpi;
            float widthRatio = 480 / dpi;
            int width = dpTopx((int) widthRatio * 20);
            b = resizeImage(context.getResources(), id, dpTopx(width), dpTopx(width));
        }
        BitmapDrawable img = new BitmapDrawable(context.getResources(), b);

        return img;
    }

    public static Bitmap resizeImage(Resources res, int resId, int width, int height)         //Used to convert image sizes
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
        final int height = options.outHeight;                                           //Get original width and height of image
        final int width = options.outWidth;
        int inSampleSize = 1;

        if (height > reqHeight || width > reqWidth) {
            final int halfHeight = height / 2;
            final int halfWidth = width / 2;
            // Calculate the largest inSampleSize value that is a power of 2 and keeps both
            // height and width larger than the requested height and width.
            while ((halfHeight / inSampleSize) > reqHeight && (halfWidth / inSampleSize) > reqWidth)
                inSampleSize *= 2;

        }

        return inSampleSize;
    }

    //-------------------------------PICTURE LOADING THREAD CLASS -------------------
    public class loadPictures implements Runnable                                            //Second thread creates array of species pictures for browse list
    {
        private ArrayList<Species> species;
        public loadPictures(ArrayList<Species> species)
        {
            this.species = species;
        }

        public void run()
        {
            if (pictures.size() != species.size())                                              //Only runs if not all pictures have been loaded
            {
                List<Species> s2;

                s2 = species.subList(pictures.size(), species.size());                          //Only runs adds pictures that haven't been added yet (list may be partially complete if screen orientation was changed)
                for (Species s : s2)
                {   if (runThread)
                    {
                        ArrayList<BitmapDrawable> pics = new ArrayList<>();

                        for (String string : s.getPhotos()) {

                            pics.add(updateBackground(string.substring(0, string.indexOf("."))));   //Create arraylist of pictures from a given phenomena
                        }
                        pictures.add(pics);
                    }//Add arraylist to pictures list
                    else
                        break;
                }
            }

            threadDone = true;
        }
    }
}
