//
//  LocationCard.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Dylan Landry on 7/18/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class LocationCard: NSObject {
    var name = String()
    var pictureName = String()
    
    init?(name: String, pictureName: String){
        
            self.name = name
            self.pictureName = pictureName
         
    }
   
}
