//
//  HelpViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by MIke Scott on 8/12/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController
{
    
    var pageViewController = TutorialPageViewController()
    override func viewDidLoad()
    {   title = "Help"
        super.viewDidLoad()
        let homeButton = UIBarButtonItem(title: "", style: .Plain , target: self, action: "goHome")

        let p1 = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + "home1", ofType: "png")
        var i = UIImage()
        if(p1 != nil)
        {
            i = UIImage(contentsOfFile: p1!)!
        }
        //Resize image
        let newSize = CGSize(width: 17, height: 15)
        let newRect = CGRectIntegral(CGRectMake(0,0, newSize.width, newSize.height))
        let imageRef = i.CGImage
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        // Set the quality level to use when rescaling
        CGContextSetInterpolationQuality(context, CGInterpolationQuality.High)
        let flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height)
        CGContextConcatCTM(context, flipVertical)
        // Draw into the context; this scales the image
        CGContextDrawImage(context, newRect, imageRef)
        let newImageRef = CGBitmapContextCreateImage(context)! as CGImage
        let newImage = UIImage(CGImage: newImageRef)
        // Get the resized image from the context and a UIImage
        UIGraphicsEndImageContext()
        

        homeButton.tintColor = UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)
        homeButton.image = newImage

        self.navigationItem.setRightBarButtonItem(homeButton, animated: false)
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)
        
        
        //Set up tutorial slideshow
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TutorialPageViewController") as! TutorialPageViewController
        self.pageViewController.fromHelp = true
        self.pageViewController.view.frame = CGRect(x: 0,y: 0, width:self.view.frame.width, height:self.view.frame.size.height)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let p1 = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + "backarrow", ofType: "png")
        var i = UIImage()
        if(p1 != nil)
        {
            
            i = UIImage(contentsOfFile: p1!)!
            
            
        }
        let backbutton = UIBarButtonItem(title: "", style: .Plain , target: self, action: "back")
        backbutton.tintColor = UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)
        backbutton.image = i
        self.navigationItem.setLeftBarButtonItem(backbutton, animated: false)
        
    }
    func back()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }

    func goHome()
    {
        let switchViewController = self.navigationController?.viewControllers[1] as! SpeciesTableViewController
        switchViewController.jsonNavigator = JsonNavigator(json: jsonResponse())
        SortThread.getSortThread().resetMatches()
        self.navigationController?.popToViewController(switchViewController, animated: true)
    }
    
    
     
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    override func shouldAutorotate() -> Bool {
        return false
    }

    
}
