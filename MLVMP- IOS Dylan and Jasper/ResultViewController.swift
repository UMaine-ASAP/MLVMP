//
//  ResultViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Dylan Landry on 7/16/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var jsonNavigator: JsonNavigator = JsonNavigator(json: jsonResponse())
    var selectedSpeciesName = String()
    var species = Species(name: "Empty", scientificName: "", tags: [], pictures: [], invasive: [],information:  [])
    var button = UIButton()
    var globalPic = UIImage()
    var spacingCounter: CGFloat = 0
    var leftIndent: CGFloat = 0
    var textWidth: CGFloat = 0
    var infoTextMargin: CGFloat = 3
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Set up nav bar icons
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
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

    override func viewDidLoad()
    {
        //Set up nav bar icons
        let homeButton = UIBarButtonItem(title: "Home", style: .Plain , target: self, action: "goHome")
        homeButton.tintColor = UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)
        self.navigationItem.setRightBarButtonItem(homeButton, animated: false)
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
        self.navigationController!.navigationBar.tintColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)]
        self.navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor(red:0.00, green:0.16, blue:0.00, alpha:1.0)
        
        //Spacing variables
        let pictureBottomMargin: CGFloat = 10
        scrollView.contentSize.height = 0
        scrollView.frame = CGRectMake(0, 0, scrollView.superview!.frame.width, scrollView.superview!.frame.height)
        
        //HEADER
        self.title = species.name
        
        
        //PICTURE
        var parsedImageName = species.pictures?[0].componentsSeparatedByString(".")
        let newImageName: String = parsedImageName![0] as String
        let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + newImageName, ofType: "jpg")
        var uncroppedImage = UIImage()
        var uncroppedImageView = UIImageView()
        if(path != nil)
        {
        
            uncroppedImage = UIImage(contentsOfFile: path!)!
            uncroppedImageView = UIImageView(image: uncroppedImage)
            
        }
        else
        {
            
        }
        
        let imageWidth = (scrollView.frame.width/20)*17
        var imageHeight = imageWidth/3*2
        let w = uncroppedImage.size.width
        let h = uncroppedImage.size.height
        
        //Scale image
        let scale = imageWidth/w
        imageHeight = h*scale

        uncroppedImageView.frame = CGRectMake((scrollView.frame.width - (scrollView.frame.width/20)*17)/3.2, 0, imageWidth, imageHeight)
        //Set up button over picture to view other pictures of species
        button.frame = CGRectMake((scrollView.frame.width - (scrollView.frame.width/20)*17)/2, 0, imageWidth, imageHeight)
                   button.addTarget(self, action: "picTap", forControlEvents: UIControlEvents.TouchUpInside)
                scrollView.addSubview(button)
        
        
        leftIndent = ((scrollView.frame.width - (scrollView.frame.width/20)*17)/3.2)
        textWidth = (scrollView.frame.width/20)*17
        spacingCounter += uncroppedImageView.frame.height + pictureBottomMargin
        scrollView.addSubview(uncroppedImageView)
        
        //Set up dots indicating how many pictures of species there are
        let dotHolder = UIView()
        let width = ((species.pictures!.count) - 1)*20 + 14
        dotHolder.frame = CGRect(x: CGFloat(0), y: spacingCounter, width: CGFloat(width), height: CGFloat(30))
        dotHolder.frame.origin.x = (UIScreen.mainScreen().bounds.width/2) - dotHolder.frame.width/2 - leftIndent/2
        var xc = 0
        for x in 0...species.pictures!.count-1
        {
            let dot = UIView()
            
            if (x == 0)
            {dot.backgroundColor = UIColor(red: 50/255, green: 82/255, blue: 50/255, alpha: 1.0)}
            else
            {dot.backgroundColor = UIColor(red: 0/255, green: 45/255, blue: 0/255, alpha: 1.0)}
            dot.frame = CGRect(x: xc, y: 2, width: 14, height: 14)
            dot.layer.cornerRadius = dot.frame.size.width/2
            dot.clipsToBounds = true
            xc += 20
            dotHolder.addSubview(dot)
            
            
        }
        scrollView.addSubview(dotHolder)
        spacingCounter += 35
       
        //Write species info to page
        
        //Loading all provided information into a dictionary so that it can be drawn into UILabels using a for loop.
        let nameArray: [String] = [species.name]
        
        var scientificNameArray = [String]()
        if(species.scientificName != nil){
        scientificNameArray = [species.scientificName!]
        }
        
        var speciesContents = ["Name": nameArray]
        var label = UILabel(frame: CGRectMake(0, spacingCounter, UIScreen.mainScreen().bounds.width-leftIndent, 50))
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .Center
        var tempArray = speciesContents["Name"]
        var tempString = tempArray?.first
        
        label.text = tempString
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        spacingCounter += label.frame.height
        scrollView.addSubview(label)

        
        if(species.scientificName != nil){
        if(scientificNameArray.count > 0){
            speciesContents["Scientific Name"] = scientificNameArray
            label = UILabel(frame: CGRectMake(0, spacingCounter, UIScreen.mainScreen().bounds.width - leftIndent, 75))
            label.lineBreakMode = .ByWordWrapping
            label.numberOfLines = 0
            label.textAlignment = .Center
            tempArray = speciesContents["Scientific Name"]
            tempString = tempArray?.first
            
            label.text = tempString
            label.font = UIFont(name: "HelveticaNeue-Italic", size: 20)
            spacingCounter += label.frame.height
            scrollView.addSubview(label)

        }
        }
        spacingCounter += 20
        for infoSection in species.information!
        {
            createLabel(infoSection.title, bullets: infoSection.bullets)
        }
        //Adjust scrollview to size of text
        if(spacingCounter > scrollView.contentSize.height)
        {
            
            scrollView.contentSize.height = spacingCounter
            scrollView.contentOffset.x = 0
            scrollView.contentOffset.y = 0
                        
        }

    }
    
    
    
    
    func createLabel(title: String, bullets: [String])
    {
        //Create label for title of section
        let label = UILabel(frame: CGRectMake(leftIndent, spacingCounter, textWidth, 20))
        label.text = title
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        if(title == "Invasive")
        {
            label.text = title + "\n"
            spacingCounter += infoTextMargin*6
        }
        spacingCounter += label.frame.height
        scrollView.addSubview(label)
    
        //Create labels for bullets
        var informationContents: [String] = bullets
        for(var index2: Int = 0; index2 < informationContents.count; index2++)
        {
            let maximumLabelSize: CGSize = CGSize(width: textWidth, height: 150)
            let labelRect: CGRect = (informationContents[0] as NSString).boundingRectWithSize(maximumLabelSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
            let informationLabel = UILabel(frame: CGRectMake(leftIndent, spacingCounter, labelRect.width, labelRect.height))
            if !(title == "Invasive")
            {
                
                
                
                informationLabel.numberOfLines = 0
                informationLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
                informationLabel.font = UIFont(name: "HelveticaNeue-Light", size: 14)
                informationLabel.text = "- " + informationContents[index2] + "\n"
                informationLabel.textAlignment = NSTextAlignment.Left
                informationLabel.preferredMaxLayoutWidth = scrollView.frame.width
                informationLabel.numberOfLines = 0
                informationLabel.frame = CGRectMake(informationLabel.frame.origin.x, informationLabel.frame.origin.y, scrollView.frame.width - 70, informationLabel.frame.height)
                informationLabel.sizeToFit()
            }
            spacingCounter += informationLabel.frame.height + infoTextMargin
            scrollView.addSubview(informationLabel)

        }
    }
    //Go to slideshow of all species pictures
    func picTap()
    {

        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("SlideshowViewController") as! SlideshowViewController
        vc.jsonNavigator = jsonNavigator
        vc.species = self.species
        self.navigationController?.pushViewController(vc as UIViewController, animated: true)
    }
    
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
    
    
    
    
    
       override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    override func shouldAutorotate() -> Bool
    {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation)
    }

    
}


