//
//  LocationViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Dylan Landry on 7/18/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class LocationViewController2: UIViewController {

    
    
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var contentView: UIView!
    var jsonNavigator: JsonNavigator = JsonNavigator(json: jsonResponse())
    var locations = [LocationCard]()
    var brownBarLeft: UIView!
    var brownBarRight: UIView!
    var buttonUIView: UIView!
    var button: UIButton!
    
    override func viewDidLoad() {
        
        locations.append(LocationCard(name: "shoreline", pictureName: "yellowish_powder1")!)
        locations.append(LocationCard(name: "surface", pictureName: "alternate_flowered_watermilfoil5")!)
        locations.append(LocationCard(name: "shallow", pictureName: "common_bladderwort6")!)
        locations.append(LocationCard(name: "deep", pictureName: "landlocked_salmon1")!)
        locations.append(LocationCard(name: "bottom", pictureName: "freshwater_sponge4")!)
        
        contentView = UIView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        contentView.backgroundColor = UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)
        
        var spacingCounter: CGFloat = 0
        
        title = "Location"
        
        for(var index: Int = 0; index < locations.count; index++){
            
            
            //Create green borders
            brownBarLeft = UIView(frame: CGRectMake(0, spacingCounter, 9, 307))
            brownBarLeft.backgroundColor = UIColor(red:0.20, green:0.32, blue:0.20, alpha:1.0)
            brownBarRight = UIView(frame: CGRectMake(view.bounds.width - 9, spacingCounter, 9, 307))
            brownBarRight.backgroundColor = UIColor(red:0.20, green:0.32, blue:0.20, alpha:1.0)
            contentView.addSubview(brownBarLeft)
            contentView.addSubview(brownBarRight)
            navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
            let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + locations[index].pictureName, ofType: "jpg")
            var image = UIImage()
            image = UIImage(contentsOfFile: path!)!

            //Resize image
            
            //Ideal proportions
            let wantedwidth = self.view.frame.width - 34
            
            
            //Actual proportions
            let width  = image.size.width
            let height = image.size.height
            
            //Adjust height based on scale
            let scale = wantedwidth/width
            let newheight = height*scale
            
            
            imageView = UIImageView(image: image)
            imageView.frame = CGRectMake(brownBarLeft.bounds.width + 9, brownBarLeft.frame.origin.y + 9, wantedwidth, newheight)
            contentView.addSubview(imageView)
            //Increase border height based on image
            brownBarLeft.frame = CGRectMake(0, spacingCounter, 9, imageView.frame.height + 68.5 + 30)
            brownBarRight.frame = CGRectMake(view.bounds.width - 9, spacingCounter, 9, imageView.frame.height + 68.5 + 30)
            
            
            //Create button shadow
            buttonUIView = UIView(frame: CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y + imageView.frame.height, imageView.frame.width, 68.5))
            buttonUIView.backgroundColor = UIColor(red:0.20, green:0.32, blue:0.20, alpha:1.0)
            buttonUIView.layer.shadowColor = UIColor.blackColor().CGColor
            buttonUIView.layer.shadowOffset = CGSizeMake(0, 4)
            buttonUIView.layer.shadowRadius = 5
            buttonUIView.layer.shadowOpacity = 1.0
            buttonUIView.layer.masksToBounds = false
            contentView.addSubview(buttonUIView)
            
            //Create button title
            button = UIButton(frame: CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.width, imageView.frame.height + buttonUIView.frame.height))
            button.setTitle(locations[index].name.capitalizedString, forState: .Normal)
            button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 22)
            button.titleEdgeInsets.top += ((imageView.frame.height + 0))
            button.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            contentView.addSubview(button)
            spacingCounter += brownBarLeft.frame.height
        }
        
        contentView.frame = CGRectMake(0, 0, view.bounds.width, spacingCounter)
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.bounces = false
        scrollView.backgroundColor = UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)
        scrollView.contentSize.height = contentView.bounds.height
        scrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        navigationController!.navigationBar.barTintColor = UIColor(red:0.07, green:0.24, blue:0.07, alpha:1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)]
        
    }
    
    func pressed(sender: UIButton!){
        
        //Add tag to sort thread
        SortThread.getSortThread().addToQueue(sender.titleLabel!.text!.lowercaseString)
        
        //Go to species table view controller filtered by location
        let speciesTableViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SpeciesTableViewController") as! SpeciesTableViewController
        speciesTableViewController.needToDisplayLocation = false
        speciesTableViewController.locationPicked = true
        speciesTableViewController.pickedLocation = sender.titleLabel!.text!
        self.navigationController!.pushViewController(speciesTableViewController, animated: true)
        
    }
    
      override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Set up nav bar icons
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
    func back()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func goHome ()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }

    
        
        

        
    

    @IBAction func pressedLocationButton(sender: AnyObject) {
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Keep application in portrait
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    override func shouldAutorotate() -> Bool {
        return false
    }


}
