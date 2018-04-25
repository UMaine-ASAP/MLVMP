//
//  LocationCell.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Dylan Landry on 7/18/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
   
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var locationPicture: UIImageView!
    @IBOutlet weak var locationButtonView: UIView!
    
    @IBOutlet weak var bottom: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
