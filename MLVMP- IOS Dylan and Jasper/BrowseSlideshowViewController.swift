//
//
//  BrowseSlideshowViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//
//This class represents the slideshow from the browse page

import UIKit

class BrowseSlideshowViewController: UIViewController
{   var jsonNavigator: JsonNavigator = JsonNavigator(json: jsonResponse())
    var species = Species(name: "Empty", scientificName: "", tags: [], pictures: [], invasive: [], information: [])
    var speciesList: [Species]!
    var pageViewController = PageViewController()
    var pageTitles: NSArray!
    var pageImages: NSArray!
    var root: UINavigationController?
    var  dotHolder = UIView()
    var startIndex = 0
    var speciesIndex = 0
    var photoIndex = 0
    var photoList = [String]()
    var label = UILabel()
    var label2 = UILabel()
    var UI = UIButton()
    var navHeight = CGFloat(0)
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //Get index of starting picture
        for var x = 0; x < speciesList.count; x++
        {   let s = speciesList[x]
            if let pics = s.pictures
            {
                photoList += pics
                if (x <= speciesIndex)
                {
                    if (x == speciesIndex)
                    {    photoIndex += startIndex}
                    else
                    {   photoIndex += pics.count
                    }
                }
            }
        }
        navHeight = self.navigationController!.navigationBar.frame.height
        //Initialize UI
        UI.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        let y = (UIScreen.mainScreen().bounds.height-self.navigationController!.navigationBar.frame.height - 60)
        UI.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height:50)
        UI.addTarget(self, action: "UITap", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        label.frame = CGRectMake(0,10,self.view.frame.width-60,40)
        label.textAlignment = NSTextAlignment.Left
        label.text = species.name
        label.font = UIFont(name: label.font.fontName, size: 16)
        label.textColor = UIColor.whiteColor()
        UI.addSubview(label)
        self.view.addSubview(UI)
        
        label2 = UILabel(frame: CGRectMake(self.view.frame.width-60,10,60,40))
        label2.textAlignment = NSTextAlignment.Left
        label2.text = "INFO  >"
        label2.font = UIFont(name: label.font.fontName, size: 16)
        label2.textColor = UIColor.whiteColor()
        
        UI.addSubview(label2)
        //Create array of dots
        var dotArray = [UIView]()
        let width = ((species.pictures!.count) - 1)*20 + 14
        dotHolder.frame = CGRect(x: 0, y: 0, width: width, height: 30)
        dotHolder.frame.origin.x = (self.view.frame.width/2) - dotHolder.frame.width/2
        var xc = 0
        for x in 0...species.pictures!.count-1
        {
            let dot = UIView()
            
            //dot.tag = x
            
            if (x == startIndex)
            {dot.backgroundColor = UIColor(red: 226/255, green: 230/255, blue: 226/255, alpha: 1.0)}
            else
            {dot.backgroundColor = UIColor(red: 50/255, green: 82/255, blue: 50/255, alpha: 1.0)}
            dot.frame = CGRect(x: xc, y: 2, width: 14, height: 14)
            dot.layer.cornerRadius = dot.frame.size.width/2
            dot.clipsToBounds = true
            xc += 20
            dotHolder.addSubview(dot)
            dotArray.append(dot)
            
        }
        //Send variables to pageViewcontroller
        self.pageTitles = photoList
        self.pageImages = photoList
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! PageViewController
        self.pageViewController.dotArray = dotArray
        
        self.pageViewController.species = self.species
        self.pageViewController.speciesIndex = speciesIndex
        self.pageViewController.photoList = photoList
        self.pageViewController.pageTitles = photoList
        self.pageViewController.pageImages = photoList
        self.pageViewController.photoIndex = self.photoIndex
        self.pageViewController.startIndex = self.startIndex
        self.pageViewController.navHeight = navHeight
        self.pageViewController.view.frame = CGRect(x: 0,y: 0, width:self.view.frame.width, height:self.view.frame.size.height)
        (self.pageViewController as PageViewController).speciesList = self.speciesList
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        UI.addSubview(dotHolder)
        self.view.addSubview(UI)
        
        
        
        
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
        
        //let image = UIImage(named: imageName as! String)
        
        
        
        
        
        
        
        homeButton.tintColor = UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)
        homeButton.image = newImage
        self.navigationItem.setRightBarButtonItem(homeButton, animated: false)

        
    }
    
    func back()
    {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //Go to species page
    
    func UITap()
    {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ResultViewController") as! ResultViewController
        vc.species = self.pageViewController.species
        vc.jsonNavigator = jsonNavigator
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        self.navigationController?.pushViewController(vc as UIViewController, animated: true)
    }
    
}
