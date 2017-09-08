//
//  SampleSpeciesClass.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Dylan Landry on 7/13/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class SampleSpeciesClass: NSObject {
   
    var name = String()
    var photo = UIImage()
    
    init(name: String, photo: String){
        self.name = name
        let imageName = photo
        self.photo = UIImage(named: imageName)!
        
    }
}
