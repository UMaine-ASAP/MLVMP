//
//  Species.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Dylan Landry on 6/24/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class Species: NSObject {
    var name = String()
    var scientificName = String?()
    var tags = [String]()
    var pictures = [String]?()
    var otherNames = [String]?()
    var invasive = [String]?()
    
    var information = [informationSectionObject]?()
    var order = 0
    
    init(name: String, scientificName: String?, tags: [String], pictures: [String], invasive: [String]?, information: [informationSectionObject]?)
    {
        self.name = name
        self.scientificName = scientificName
        self.tags = tags
        self.pictures = pictures
        self.invasive = invasive
        self.information = information
        if tags.contains("other aquatic curiosities")
        {
            switch name{
             case "Transparent Brown Water":
                self.order = 1
             case "Green Colored Water":
                self.order = 2
             case "Murky or Cloudy (Turbid) Water":
                self.order = 3
             case "Lines of Foam/Debris":
                self.order = 4
             case "Clumps of Foam":
                self.order = 5
             case "Oily Sheen":
                self.order = 6
             case "Orange or Reddish Brown Slime":
                self.order = 7
             case "Yellowish Powder":
                self.order = 8
             case "Lake Balls":
                self.order = 9
             case "Lines on Rocks":
                self.order = 10
             case "Fish Kills":
                self.order = 11
             case "Insect Exuvia":
                self.order = 12
             default:
                self.order = 0
                
                
                
                
                
                
            }
        }
       
        
    }
}
