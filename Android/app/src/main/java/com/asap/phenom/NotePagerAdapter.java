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
public class NotePagerAdapter extends PagerAdapter
{


    Context context;
    LayoutInflater inflater;
    String tag;

    public NotePagerAdapter(Context context, boolean fromMainPage) {
        this.context = context;
        inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);

    }

    @Override
    public int getCount()
    {
        return 2;
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
        itemView = inflater.inflate(R.layout.note_view1, container, false);
        TextView text = (TextView) itemView.findViewById(R.id.noteText);
        switch (tag)
        {


            case "algae that color the water":
                text.setText("\tThere are many forms of free-floating (planktonic) algae capable of coloring the water (like spilled paint).  This can make it challenging to identify a particular algal occurance to the level of genus and/or species.  In most cases, careful microscopic examination using more complete taxinomic keys will be required.  The taxonmic categories (genera) of algae featured in this section are not comprehensive; a few only are listed to help illustrate the biological diversity within this group.");
                break;
            case "cotton-candy or cloud-like algae":
                text.setText("\tThere are several types of algae capable of producing cotton-candy-like clouds, making it challenging to identify a particular algal occurance to the level of genus and/or species.  In most cases, careful microscopic examination using more complete taxinomic keys will be required. The taxonmic categories (genera) of algae featured in this section are not comprehensive; a few only are listed to help illustrate the biological diversity within this group.");
                break;
            case "filamentous mat-forming algae":
                text.setText("\tThere are many forms of algae capable of producing mats, making it challenging to identify a particular algal occurance to the level of genus and/or species.  In most cases, careful microscopic examination using more complete taxinomic keys will be required.  The taxonmic categories (genera) of algae featured in this section are not comprehensive; a few only are listed to help illustrate the biological diversity within this group.");
            default:
                break;

        }
        if (position == 1)
        {
            itemView.findViewById(R.id.noteText).setVisibility(View.GONE);
            itemView.findViewById(R.id.swipeText).setVisibility(View.GONE);
        }



        container.addView(itemView);
        return itemView;
    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        container.removeView((LinearLayout) object);
    }














}
