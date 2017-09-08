//
//  TableViewCell.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Dylan Landry on 7/13/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var speciesImageView: UIImageView!
    @IBOutlet weak var speciesUIButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    @IBOutlet weak var buttonBottomY: NSLayoutConstraint!
    @IBOutlet weak var bot: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var imageY: NSLayoutConstraint!
    @IBOutlet weak var buttonY: NSLayoutConstraint!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
