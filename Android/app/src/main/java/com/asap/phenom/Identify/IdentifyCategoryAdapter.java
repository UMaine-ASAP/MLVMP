package com.asap.phenom.Identify;

import com.asap.phenom.*;

import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.BitmapDrawable;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import java.util.ArrayList;

/**
 * Created by Katrina on 6/17/15.
 *
 * This class governs the listview of category buttons / pictures in the Identify class
 */
public class IdentifyCategoryAdapter extends ArrayAdapter<treeNode>
{
    public IdentifyCategoryAdapter(Context context, ArrayList<treeNode> nodes)
    {
        super(context, 0, nodes);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent)               //Get new view for list
    {
        treeNode node = getItem(position);

        if (convertView== null)
            convertView = LayoutInflater.from(getContext()).inflate(R.layout.button_layout, parent, false);

        Button categoryName = (Button) convertView.findViewById(R.id.button);
        categoryName.setText(capitalizeFirst(node.getNodeName()));

        ImageView image = (ImageView) convertView.findViewById(R.id.image);
        updateBackground(image, node.getPhoto().substring(0, node.getPhoto().indexOf(".")));
        return convertView;
    }
    public String capitalizeFirst(String s)                                             //Capitalize first letter of each word in string
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
    public int dpTopx(int dp)                                                         //Converts pixels to dp
    {
        return (int) (dp * getContext().getResources().getDisplayMetrics().density);
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
        else {

            int dpi = context.getResources().getDisplayMetrics().densityDpi;
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



}



