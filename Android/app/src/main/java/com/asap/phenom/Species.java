package com.asap.phenom;

import android.os.Parcel;
import android.os.Parcelable;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Katrina on 6/2/2015.
 *
 * This class creates an object which models data about an individual species
 *
 */
public class Species implements Parcelable
{   private String name;
    private ArrayList<String> tags;
    private List<String> information;
    private List<String> photos;
    private String scientific_name;
    private int invasive;
    private int order;


    public Species(String name, String sci_name, ArrayList<String> tags, List<String> information, List<String> photos, int invasive)
    {
        this.name = name;
        this.scientific_name=sci_name;
        this.tags = tags;
        this.information = information;
        this.photos = photos;
        this.invasive = invasive;
        switch (name.toLowerCase())
        {
            case "transparent brown water":
                this.order = 1;
                break;
            case "green colored water":
                this.order = 2;
                break;
            case "murky or cloudy (turbid) water":
                this.order = 3;
                break;
            case "lines of foam/debris":
                this.order = 4;
                break;
            case "clumps of foam":
                this.order = 5;
                break;
            case "oily sheen":
                this.order = 6;
                break;
            case "orange or reddish brown slime":
                this.order = 7;
                break;
            case "yellowish powder":
                this.order = 8;
                break;
            case "lake balls":
                this.order = 9;
                break;
            case "lines on rocks":
                this.order = 10;
                break;
            case "fish kills":
                this.order = 11;
                break;
            case "insect exuvia":
                this.order = 12;
                break;
            default:
                this.order = 0;
         }

    }
    public int getOrder()
    {
        return order;
    }
    public String getName()                                                         //Returns name of species
    {
        return name;
    }
    public String getScientific_name()
    {
        return scientific_name;
    }

    public List<String> getInformation()
    {
        return information;
    }
    public ArrayList<String> getTags()                                              //Returns tags associated with species
    {
        return tags;
    }


    public List<String> getPhotos()
    {
        return photos;
    }

    public String getFirstPhoto()
    {
        return photos.get(0);
    }

    public boolean isInvasive()
    { if (invasive == 1)
        return true;
      else
        return false;
    }
    public Species(Parcel source)                                                   //Used for removing species from parcel
    {
        name = source.readString();
        scientific_name = source.readString();
        information = new ArrayList<String>();
        source.readStringList(information);
        photos = new ArrayList<String>();
        source.readStringList(photos);
        invasive = source.readInt();
    }

    public int describeContents()                                                   //Used for putting species in parcel
    {
        return this.hashCode();
    }


    public void writeToParcel(Parcel dest, int flags)                               //Allows Species to be put in parcel
    {
        dest.writeString(name);
        dest.writeString(scientific_name);
        dest.writeStringList(information);
        dest.writeStringList(photos);
        dest.writeInt(invasive);


    }
    public static final Parcelable.Creator CREATOR = new Parcelable.Creator()       //Used for creating species from parcelable
    {
        public Species createFromParcel(Parcel in)
        {
            return new Species(in);
        }

        public Species[] newArray(int size)
        {
            return new Species[size];
        }
    };

}
