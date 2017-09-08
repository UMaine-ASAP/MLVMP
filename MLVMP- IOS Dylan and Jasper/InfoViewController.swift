//
//  InfoViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by MIke Scott on 8/12/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var t1: UITextView!
    
   
    override func viewDidLoad() {
        
        //Essentially, set up a ton of text
        super.viewDidLoad()
        title = "Info"
        let helpButton = UIBarButtonItem(title: "Help", style: .Plain , target: self, action: "goToHelp")
        helpButton.tintColor = UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)
        self.navigationItem.setRightBarButtonItem(helpButton, animated: false)
        
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)
        let screenSize = UIScreen.mainScreen().bounds
        let indent: CGFloat = 17
        let information = "The Mission of the Maine Volunteer Lake Monitoring Program is to help protect Maine lakes through widespread citizen participation in the gathering and dissemination of credible scientific information pertaining to lake health. The VLMP trains, certifies and provides technical support to hundreds of volunteers who monitor a wide range of indicators of water quality, assess watershed health and function, and screen lakes for invasive aquatic plants and animals. In addition to being the primary source of lake data in the State of Maine, VLMP volunteers benefit their local lakes by playing key stewardship and leadership roles in their communities."
        let generalInformation = "The VLMP is a non-profit 501(c)(3) organization committed to the collection of information pertaining to lake water quality. For 40 years, trained volunteers throughout Maine have donated their time so that we may all learn more about one of Maine’s most beautiful and important resources — our lakes."
        var contactInformation = ["The Maine Volunteer Lake Monitoring Program", "24 Maple Hill Road", "Auburn, Maine 04210", "Phone: 207-783-7733", "Email:  vlmp@mainevlmp.org"]
        
        
        //image
        let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + "MVLMPlogoforhelp", ofType: "png")
        var image1 = UIImage()
        
        if (path != nil){
            image1 = UIImage(contentsOfFile: path!)!
        }
        
        let imageview = UIImageView(image: image1)
        
        let imageviewAspectRatio = imageview.bounds.width/imageview.bounds.height
        imageview.frame = CGRect(x: indent, y: indent, width: screenSize.width - indent*2, height: (screenSize.width - indent*2)/imageviewAspectRatio)
        imageview.frame.origin.x = (self.view.frame.width/2) - (imageview.frame.width/2)
        scrollView.contentSize.height += imageview.frame.height + indent
        scrollView.addSubview(imageview)
        
        let ourMissionHeader = UILabel(frame: CGRectMake(0, scrollView.contentSize.height + indent, screenSize.width, 25))
        ourMissionHeader.text = "Our Mission"
        ourMissionHeader.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
        ourMissionHeader.textColor = UIColor(red: 0, green: 0.157, blue: 0, alpha: 1)
        ourMissionHeader.textAlignment = NSTextAlignment.Center
        scrollView.addSubview(ourMissionHeader)
        scrollView.contentSize.height += ourMissionHeader.bounds.height + indent
        
        let maximumInformationFrameSize: CGSize = CGSize(width: screenSize.width - indent*2, height: 1000)
        let labelRect: CGRect = (information as NSString).boundingRectWithSize(maximumInformationFrameSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
        let informationLabel = UILabel(frame: CGRectMake(indent, scrollView.contentSize.height + indent, labelRect.width, labelRect.height))
        informationLabel.text = information
        informationLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        informationLabel.textColor = UIColor(red: 0, green: 0.157, blue: 0, alpha: 1)
        //informationLabel.textColor = UIColor.blackColor()
        informationLabel.numberOfLines = 0
        informationLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        informationLabel.sizeToFit()//Trims excess space off of top and bottom of frame. Comment out to see example.
        scrollView.addSubview(informationLabel)
        scrollView.contentSize.height += informationLabel.bounds.height + indent
        
        let generalInformationHeader = UILabel(frame: CGRectMake(0, scrollView.contentSize.height + indent, screenSize.width, 25))
        generalInformationHeader.text = "General Information"
        generalInformationHeader.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
        generalInformationHeader.textColor = UIColor(red: 0, green: 0.157, blue: 0, alpha: 1)
        generalInformationHeader.textAlignment = NSTextAlignment.Center
        scrollView.addSubview(generalInformationHeader)
        scrollView.contentSize.height += generalInformationHeader.frame.height + indent
        
        let maximumGeneralInformationFrameSize = CGSize(width: screenSize.width - indent*2, height: 1000)
        let generalInformationRect: CGRect = (generalInformation as NSString).boundingRectWithSize(maximumGeneralInformationFrameSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
        let generalInformationLabel = UILabel(frame: CGRectMake(indent, scrollView.contentSize.height + indent, generalInformationRect.width, generalInformationRect.height))
        generalInformationLabel.text = generalInformation
        generalInformationLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        generalInformationLabel.textColor = UIColor(red: 0, green: 0.157, blue: 0, alpha: 1)
        generalInformationLabel.numberOfLines = 0
        generalInformationLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        generalInformationLabel.sizeToFit()
        scrollView.addSubview(generalInformationLabel)
        scrollView.contentSize.height += generalInformationLabel.frame.height + indent
        
        let contactLabel = UILabel(frame: CGRectMake(0, scrollView.contentSize.height + indent, screenSize.width, 25))
        contactLabel.text = "Contact"
        contactLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 22)
        contactLabel.textColor = UIColor(red: 0, green: 0.157, blue: 0, alpha: 1)
        contactLabel.textAlignment = NSTextAlignment.Center
        scrollView.addSubview(contactLabel)
        scrollView.contentSize.height += contactLabel.frame.height + indent
        
        for(var i = 0; i < contactInformation.count; i++){
            
            let maximumContactInformationFrameSize = CGSize(width: screenSize.width - indent*2, height: 200)
            let contactInformationRect: CGRect = (contactInformation[i] as NSString).boundingRectWithSize(maximumContactInformationFrameSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
            let contactInformationLabel = UILabel(frame: CGRectMake(indent, scrollView.contentSize.height + indent, contactInformationRect.width, contactInformationRect.height))
            contactInformationLabel.text = contactInformation[i]
            contactInformationLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            contactInformationLabel.textColor = UIColor(red: 0, green: 0.157, blue: 0, alpha: 1)
            contactInformationLabel.numberOfLines = 0
            contactInformationLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            contactInformationLabel.sizeToFit()
            scrollView.addSubview(contactInformationLabel)
            scrollView.contentSize.height += contactInformationLabel.frame.height
            
        }
        
        scrollView.contentSize.height += indent
        
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
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    override func shouldAutorotate() -> Bool {
        return false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func goToHelp()
    {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("HelpViewController") as! HelpViewController
        self.navigationController?.pushViewController(vc as UIViewController, animated: true)
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}