
//
//  HomeViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Administrator on 7/15/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import Foundation


import UIKit

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var text: UITextView!
    
    var jsonNavigator = JsonNavigator(json: jsonResponse())
    var sortThread = SortThread.getSortThread()
    
    //Enter app
    func proceed()
    {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("SpeciesTableViewController") as! SpeciesTableViewController
        vc.jsonNavigator = jsonNavigator
        self.navigationController?.pushViewController(vc as UIViewController, animated: true)
    }
    
    override func viewDidAppear(animated: Bool)
    {
        //Change title of button depending on first launch of app or not
        let notfirstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if notfirstLaunch
        {
            proceedButton.setTitle("Explore Aquatic Phenomena", forState: .Normal)
        }
        else
        {
            proceedButton.setTitle("Proceed to Tutorial", forState: UIControlState.Normal)
            
        }
        
    }
    
    override func viewDidLoad()
    {
        
        text.frame = CGRectMake(35, 92, 312, 109)
        //Set up navigation bar
        self.title = "Welcome"
        navigationController!.navigationBar.barTintColor = UIColor(red:0.07, green:0.24, blue:0.07, alpha:1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)]
        self.navigationController!.navigationBar.translucent = false
        
        //Set up logo for welcome page
        proceedButton.addTarget(self, action: "proceed", forControlEvents: UIControlEvents.TouchUpInside)
        let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + "MVLMPlogoforhelp", ofType: "png")
        var image1 = UIImage()
        if (path != nil)
        {
          image1 = UIImage(contentsOfFile: path!)!
        }
       
        let imageAspectRatio = image.bounds.width / image.bounds.height
        let imageview = UIImageView(image: image1)
        imageview.frame = CGRectMake(18, 160, UIScreen.mainScreen().bounds.width - 32, (UIScreen.mainScreen().bounds.width - 20)/imageAspectRatio)
        self.view.addSubview(imageview)
        
        //Start species sorting thread
        sortThread.getThread().start()
  
        
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    override func shouldAutorotate() -> Bool {
        return false
    }

    
}
//Initialize search tree from json file
func jsonResponse() -> [String : AnyObject] {
    
    let path = NSBundle.mainBundle().pathForResource("searchTree(complete)", ofType: "json")!
    let data = try? NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingUncached)
    let json: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
    
    return json as! [String : AnyObject]
}

