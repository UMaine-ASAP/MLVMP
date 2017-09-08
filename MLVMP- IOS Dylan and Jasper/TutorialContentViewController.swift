//
//  TutorialContentViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by MIke Scott on 8/11/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class TutorialContentViewController: UIViewController
{
    
    var imageView: UIImageView!
    var pageIndex: Int!
    var titleIndex: String!
    var imageFile: String!
    private var scrollViewDidScrollOrZoom = false
    var textView = UITextView()
    var swipe = UIButton()
    var largeImageView = UIImageView()
    var button = UIButton()
    var smallImg1 = UIImageView()
    var smallImg2 = UIImageView()
    var smallImg3 = UIImageView()
    var smallImg4 = UIImageView()
    var fromHelp = false
    var dotArray = [UIView]()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fromHelp = (self.parentViewController as! TutorialPageViewController).fromHelp
        textView = UITextView(frame: CGRectMake(20,90, 300, 110))
        textView.editable = false
        //Set up text and images for various pages
        textView.frame.origin.x = (self.view.frame.width/2) - 150
        textView.font = UIFont(name: "Helvetica Neue", size: 20)
        textView.text = "The following pages will explain how to identify phenomena."
        textView.backgroundColor = UIColor(white: 1, alpha: 0.0)
        textView.textColor = UIColor.whiteColor()
        textView.textAlignment = NSTextAlignment.Center
        self.view.addSubview(textView)
        
        let swipeY = UIScreen.mainScreen().bounds.height - 150
        swipe = UIButton(frame: CGRectMake(20,swipeY,300,50))
        swipe.frame.origin.x =  (self.view.frame.width/2) - 150
        swipe.setTitle("Swipe to navigate  <", forState: .Normal)
        swipe.backgroundColor = UIColor(white: 1, alpha: 0)
        swipe.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(swipe)
        
        let imgWidth = UIScreen.mainScreen().bounds.width - 40
        largeImageView = UIImageView(frame: CGRectMake(0,10,imgWidth,2*(imgWidth/3)))
        resizeImage(largeImageView, newImageName: "bull_frog1", width: imgWidth, height: CGFloat(2*(imgWidth/3)))
        largeImageView.frame.origin.x = (self.view.frame.width/2) - imgWidth/2
        
        button = UIButton(frame: CGRectMake(0,0,imgWidth,imgWidth/4))
        button.backgroundColor = UIColor(red: 50/255, green: 80/255, blue: 50/255, alpha: 1.0)
        button.setTitle("Fauna", forState: .Normal)
        button.frame.origin.y = largeImageView.frame.origin.y + 2*(imgWidth/3)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.frame.origin.x = (self.view.frame.width/2) - imgWidth/2
        
        let arrow = UIImageView(frame: CGRectMake(0, 90, 100, 100))
        let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + "tutorial_arrow", ofType: "png")
        
        if(path != nil)
        {
            arrow.image = UIImage(contentsOfFile: path!)!
        }
        arrow.frame.origin.x = (self.view.frame.width/2) - 50
        
        let nostocLabel = UILabel(frame: CGRectMake(0,195,100,30))
        nostocLabel.text = "Nostoc"
        nostocLabel.textAlignment = NSTextAlignment.Left
        nostocLabel.frame.origin.x = (self.view.frame.width/2)-147
        nostocLabel.font = UIFont(name: "Helvetica Neue", size: 18)
        nostocLabel.textColor = UIColor.whiteColor()
        nostocLabel.backgroundColor = UIColor(white: 1, alpha: 0)
        
        let x = (self.view.frame.width/2)-147
        let smallImg1 = UIImageView(frame: CGRectMake(x,220,70,70))
        let smallImg2 = UIImageView(frame: CGRectMake(x+75,220,70,70))
        let smallImg3 = UIImageView(frame: CGRectMake(x+150,220,70,70))
        let smallImg4 = UIImageView(frame: CGRectMake(x+225,220,70,70))
        resizeImage(smallImg1, newImageName: "nostoc1", width: 55, height: 55)
        resizeImage(smallImg2, newImageName: "nostoc2", width: 55, height: 55)
        resizeImage(smallImg3, newImageName: "nostoc3", width: 55, height: 55)
        resizeImage(smallImg4, newImageName: "nostoc4", width: 55, height: 55)
        
        let infoLabel = UILabel(frame: CGRectMake(0,100,100,40))
        let infoButton = UIButton(frame: CGRectMake(0,100,15,15))
        if(fromHelp){
            infoLabel.text = "Help"
        } else {
            infoLabel.text = "Info"
        }
        
        infoLabel.textAlignment = NSTextAlignment.Center
        infoLabel.frame.origin.x = (self.view.frame.width/2) - 50
        infoButton.frame.origin.x = (self.view.frame.width/2) - 7
        
        let path1 = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + "abt", ofType: "png")
        var image = UIImage()
        
        
        
        if (path1 != nil)
        {
            image = UIImage(contentsOfFile: path1!)!
        }
        infoButton.imageView!.image = image
        infoLabel.font = UIFont(name: "Helvetica Neue", size: 26)
        infoLabel.textColor = UIColor.whiteColor()
        infoLabel.backgroundColor = UIColor(white: 1, alpha: 0)
       
        //Change contents of page based on index
        switch pageIndex
        {
        case (0):
            textView.text = "The following pages will explain how to identify phenomena."
        case (1):
            textView.text = "Tapping a category allows you to view its corresponding species or sub-categories."
            self.view.addSubview(button)
            self.view.addSubview(largeImageView)
            textView.frame.origin.y =  imgWidth
            textView.textAlignment = NSTextAlignment.Left
            swipe.removeFromSuperview()
        case (2):
            textView.text = "Red indicates that a species is invasive."
            resizeImage(largeImageView, newImageName: "common_reed1", width: 340, height: 230)
            button.backgroundColor = UIColor(red: 0.5, green: 0, blue: 0, alpha: 1.0)
            button.setTitle("Common Reed", forState: .Normal)
            self.view.addSubview(button)
            self.view.addSubview(largeImageView)
            textView.frame.origin.y =  imgWidth
            textView.textAlignment = NSTextAlignment.Left
            swipe.removeFromSuperview()
        case (3):
            textView.text = "Tapping \"Browse All\" will display categories as a collection of interactive photos."
            textView.textAlignment = NSTextAlignment.Left
            button.setTitle("Browse All", forState: .Normal)
            button.frame.origin.y = 10
            textView.frame.origin.y =  imgWidth + 10
            self.view.addSubview(button)
            self.view.addSubview(arrow)
            self.view.addSubview(nostocLabel)
            self.view.addSubview(smallImg1)
            self.view.addSubview(smallImg2)
            self.view.addSubview(smallImg3)
            self.view.addSubview(smallImg4)
            swipe.removeFromSuperview()
        case (4):
            if (!fromHelp)
            {
                textView.text = "Tap the Info button to see these tips again and see information about the people behind the app."
                button.setTitle("Explore Aquatic Phenomena", forState: .Normal)
                self.view.addSubview(infoButton)
            }
            else
            {
                textView.text = "Tap \"Help\" on the Info screen to see this tutorial again."
                button.setTitle("Return to Info", forState: .Normal)
                self.view.addSubview(infoLabel)
            }
            textView.textAlignment = NSTextAlignment.Left
            textView.frame.origin.y =  150
            
            
            button.frame.origin.y = UIScreen.mainScreen().bounds.height - 200
            if fromHelp
            {
                button.addTarget(self.parentViewController?.parentViewController, action: "back", forControlEvents: UIControlEvents.TouchUpInside)
            }
            else
            {
                button.addTarget(self.parentViewController?.parentViewController, action: "endTutorial", forControlEvents: UIControlEvents.TouchUpInside)
            }
            self.view.addSubview(button)
            swipe.removeFromSuperview()
        default:
            textView.text = "a"
        }
        
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    override func shouldAutorotate() -> Bool {
        return false
    }

    func resizeImage(img: UIImageView, newImageName: String, width: CGFloat, height: CGFloat)
    {
        let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + newImageName, ofType: "jpg")
        var image = UIImage()
        
        
        img.contentMode = UIViewContentMode.ScaleAspectFit
        if (path != nil)
        {
            image = UIImage(contentsOfFile: path!)!
        }
        
        //Resize image
        let newSize = CGSize(width: width, height: height)
        let newRect = CGRectIntegral(CGRectMake(0,0, newSize.width, newSize.height))
        let imageRef = image.CGImage
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
        if (path != nil)
        {
            img.image = newImage
        }
        
        
    }
    deinit
    {
        
        
        smallImg1.image = nil
        smallImg2.image = nil
        smallImg3.image = nil
        smallImg4.image = nil
        largeImageView.image = nil
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        dotArray[pageIndex].backgroundColor = UIColor(red: 226/255, green: 230/255, blue: 226/255, alpha: 1.0)
        
        
    }
    
    override func viewDidDisappear(animated: Bool)
    {
        super.viewDidDisappear(animated)
        dotArray[pageIndex].backgroundColor = UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1.0)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
