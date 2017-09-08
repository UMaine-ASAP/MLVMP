
//
//  SlideshowViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by MIke Scott on 7/28/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//
//  This class represents the slideshow on the result page

import UIKit

class SlideshowViewController: UIViewController
{
    var jsonNavigator: JsonNavigator = JsonNavigator(json: jsonResponse())
    var species = Species(name: "Empty", scientificName: "", tags: [], pictures: [], invasive: [],  information: [])
    var pageViewController = ResultPageViewController()
    var pageTitles: NSArray!
    var pageImages: NSArray!
    var root: UINavigationController?
    var  dotHolder = UIView()
    var startIndex = 0
    var UI = UIButton()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Set up page controller vars
        self.pageTitles = species.pictures
        self.pageImages = species.pictures
        self.title = species.name
        //Set up page controller to view species images
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ResultPageViewController") as! ResultPageViewController
        self.pageViewController.species = self.species
        self.pageViewController.pageTitles = species.pictures
        self.pageViewController.pageImages = species.pictures
        self.pageViewController.startIndex = self.startIndex
        self.pageViewController.view.frame = CGRect(x: 0,y: 30, width:self.view.frame.width, height:self.view.frame.height )
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        //Set up transparent black UI to hold dots indicating current / other pictures
        UI.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        let y = (UIScreen.mainScreen().bounds.height-self.navigationController!.navigationBar.frame.height - 40)
        UI.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height:30)
        //Set up photo indicators
        var dotArray = [UIView]()
        //Center them
        let width = ((species.pictures!.count) - 1)*20 + 14
        dotHolder.frame = CGRect(x: 0, y: 0, width: width, height: 30)
        dotHolder.frame.origin.x = (self.view.frame.width/2) - dotHolder.frame.width/2
        var xc = 0
        for x in 0...species.pictures!.count-1
        {
            let dot = UIView()
            
            //Color first dot light
            if (x == startIndex)
            {dot.backgroundColor = UIColor(red: 226/255, green: 230/255, blue: 226/255, alpha: 1.0)}
            //Color other dots dark
            else
            {dot.backgroundColor = UIColor(red: 50/255, green: 82/255, blue: 50/255, alpha: 1.0)}
            dot.frame = CGRect(x: xc, y: 2, width: 14, height: 14)
            dot.layer.cornerRadius = dot.frame.size.width/2
            dot.clipsToBounds = true
            xc += 20
            dotHolder.addSubview(dot)
            dotArray.append(dot)
            
        }
        self.pageViewController.dotArray = dotArray
        UI.addSubview(dotHolder)
        self.view.addSubview(UI)
        
        
        
       //Set up navigation bar
        let p1 = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + "close", ofType: "png")
        var i = UIImage()
        if(p1 != nil)
        {
            i = UIImage(contentsOfFile: p1!)!
        }
        //Resize image
        let newSize1 = CGSize(width: 15, height: 15)
        let newRect1 = CGRectIntegral(CGRectMake(0,0, newSize1.width, newSize1.height))
        let imageRef1 = i.CGImage
        UIGraphicsBeginImageContextWithOptions(newSize1, false, 0)
        let context1 = UIGraphicsGetCurrentContext()
        // Set the quality level to use when rescaling
        CGContextSetInterpolationQuality(context1, CGInterpolationQuality.High)
        let flipVertical1 = CGAffineTransformMake(1, 0, 0, -1, 0, newSize1.height)
        CGContextConcatCTM(context1, flipVertical1)
        // Draw into the context; this scales the image
        CGContextDrawImage(context1, newRect1, imageRef1)
        let newImageRef1 = CGBitmapContextCreateImage(context1)! as CGImage
        let newImage1 = UIImage(CGImage: newImageRef1)
        // Get the resized image from the context and a UIImage
        UIGraphicsEndImageContext()
        
        //let image = UIImage(named: imageName as! String)
        let backbutton = UIBarButtonItem(title: "", style: .Plain , target: self, action: "back")
        backbutton.tintColor = UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)
        backbutton.image = newImage1
        self.navigationItem.setLeftBarButtonItem(backbutton, animated: false)
        
        
        let homeButton = UIBarButtonItem(title: "", style: .Plain , target: self, action: "goHome")
        let p2 = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + "home1", ofType: "png")
        i = UIImage()
        if(p2 != nil)
        {
            i = UIImage(contentsOfFile: p2!)!
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
    }
    
    //Go to home page
    func goHome()
    {
        let switchViewController = self.navigationController?.viewControllers[1] as! SpeciesTableViewController
        let times = jsonNavigator.orderOfNavigation.count
        switchViewController.jsonNavigator = JsonNavigator(json: jsonResponse())
        SortThread.getSortThread().resetMatches()
        
        for (var x = 0; x < times; x++)
        {
            jsonNavigator.regress()
        }
        self.navigationController?.popToViewController(switchViewController, animated: true)

    }
    
    func back()
    {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
}
