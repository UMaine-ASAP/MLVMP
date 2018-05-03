package com.asap.phenom.Identify;

import com.asap.phenom.Species;

import java.util.Comparator;

public class OrderComparator implements Comparator<Species>
{
    public int compare (Species s1, Species s2)
    {
        return s1.getOrder() - s2.getOrder();
    }
}