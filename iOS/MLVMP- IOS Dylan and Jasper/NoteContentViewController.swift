//
//  NoteContentViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by MIke Scott on 1/22/16.
//  Copyright (c) 2016 Dylan Landry. All rights reserved.
//

import UIKit

class NoteContentViewController: UIViewController
{
    
    
    var pageIndex: Int!
    var titleIndex: String!
    var textView = UITextView()
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var swipeText: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.0)
        
        noteText.backgroundColor = UIColor(white: 1, alpha: 0.0)
        noteText.textColor = UIColor.whiteColor()
      
        swipeText.backgroundColor = UIColor(white: 1, alpha: 0.0)
        swipeText.textColor = UIColor.whiteColor()
        self.view.addSubview(textView)
        
        
        if (pageIndex == 0)
        {
            //change note text depending on which algae is current
            switch ((self.parentViewController as! NotePageViewController).tag)
            {
                case "filamentous mat-forming algae":
                    noteText.text = "There are many forms of algae capable of producing mats, making it challenging to identify a particular algal occurance to the level of genus and/or species.  In most cases, careful microscopic examination using more complete taxinomic keys will be required.  The taxonmic categories (genera) of algae featured in this section are not comprehensive; a few only are listed to help illustrate the biological diversity within this group."
                case "cotton candy-like clouds of algae":
                    noteText.text = "There are several types of algae capable of producing cotton-candy-like clouds, making it challenging to identify a particular algal occurance to the level of genus and/or species.  In most cases, careful microscopic examination using more complete taxinomic keys will be required. The taxonmic categories (genera) of algae featured in this section are not comprehensive; a few only are listed to help illustrate the biological diversity within this group."
                case "algae that color the water":
                    noteText.text = "There are many forms of free-floating (planktonic) algae capable of coloring the water (like spilled paint).  This can make it challenging to identify a particular algal occurance to the level of genus and/or species.  In most cases, careful microscopic examination using more complete taxinomic keys will be required.  The taxonmic categories (genera) of algae featured in this section are not comprehensive; a few only are listed to help illustrate the biological diversity within this group."
                default:
                    noteText.text = ""
            }
            
        }
        else
        {
            swipeText.hidden = true
            noteText.hidden = true
        }
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    
  
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (pageIndex == 1)
        {
            self.parentViewController!.view.hidden = true
        }
        
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        super.viewDidDisappear(animated)
        
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
