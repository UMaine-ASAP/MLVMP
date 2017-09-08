//
//  informationSectionObject.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by MIke Scott on 4/20/16.
//  Copyright © 2016 Dylan Landry. All rights reserved.
//

import UIKit
//Section of species information
class informationSectionObject: NSObject {
    var title = String()
    var bullets = [String]()
    var order = 0
    
    init(title: String, bullets: [String]) {
        self.title = title
        self.bullets = bullets
        //Several types of sections have certain ordering
        switch title
        {
        case "Other Name(s)":
            self.order = -10
        case "Order":
            self.order = -9
        case "Family":
            self.order = -9
        case "Invasive":
            self.order = -8
        case "Identifying Characteristics":
            self.order = -7
        case "Details":
            self.order = -7
        case "Biology":
            self.order = -6
        case "Diet":
            self.order = -5
        case "Habitat":
            self.order = -4
        case "Look-Alikes":
            self.order = -3
        case "Commonly Seen":
            self.order = -2
        case "Range":
            self.order = -1
        default:
            self.order = 0
        }
    }
}