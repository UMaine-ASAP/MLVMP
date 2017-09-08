//
//  Card.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Administrator on 7/14/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import Foundation

import UIKit

class Card{
    
    var name: String
    var pictureName: String
    var invasive: Bool
    
    init(name: String, pictureName: String, invasive: Bool){
        self.name = name
        self.pictureName = pictureName
        self.invasive = invasive
    }
    

}