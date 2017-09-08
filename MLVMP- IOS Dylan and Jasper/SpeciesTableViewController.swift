//
//  TableViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Dylan Landry on 7/13/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class SpeciesTableViewController: UITableViewController {
    
    
    @IBOutlet weak var info: UIBarButtonItem!
    // MARK: Properties
    
    var locationPicked = Bool()                                             //If location button is clicked
    var jsonNavigator: JsonNavigator = JsonNavigator(json: jsonResponse())  //Navigates through json search tree
    var needToDisplayLocation: Bool = true                                  //if start needsLocation
    var pickedLocation = String()
    var arrayOfCards = [Card]()                                             //Array of Cards representing species / categories
    var notfirstLaunch = true
    var pageViewController = TutorialPageViewController()                   //Governs tutorial that shows on first use after install
    var heights = [CGFloat]()
    override func viewDidLoad() {
        
        
        //Also happens in the advance func.
        jsonNavigator.updateCards()
        arrayOfCards = jsonNavigator.cards                                  //Get new cards
        var index = 0
        
        
        for c in arrayOfCards
        {
            //Get image for card
            var parsedImageName = c.pictureName.componentsSeparatedByString(".")
            let newImageName: String = parsedImageName[0] as String
            let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + newImageName, ofType: "jpg")
            var image = UIImage()
            
            if(path != nil){
                image = UIImage(contentsOfFile: path!)!
            }
            
            //Ideal proportions
            let wantedwidth = self.view.frame.width - 34
            
            
            //Actual proportions
            let width  = image.size.width
            let height = image.size.height
            
            //Adjust height based on scale
            let scale = wantedwidth/width
            let newheight = height*scale
            heights.append(newheight)
            index++

        
        }
        if(locationPicked != false && (locationPicked != true))
        {
            locationPicked = false
        }
        
        super.viewDidLoad()
        
        //Adjust tableview and nav bar appearance
        info.tintColor = UIColor.whiteColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.bounces = false
        self.tableView.backgroundColor =  UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)]
        self.navigationController!.navigationBar.translucent = false
        let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + "backarrow", ofType: "png")
        var image = UIImage()
        
        if (path != nil)
        {
            image = UIImage(contentsOfFile: path!)!
        }
        backButton.enabled = true
        backButton.image = image
        
        
        var newJson = [String: AnyObject]()
        if((!(needToDisplayLocation)) && locationPicked)
        {
            
            for(var i = 0; i < arrayOfCards.count; i++)
            {
                
                if(jsonNavigator.json[arrayOfCards[i].name] != nil)
                {
                    
                    newJson = jsonNavigator.json[arrayOfCards[i].name] as! [String : AnyObject]
                    if(!(jsonNavigator.checkAvail(newJson, categoryToCheck: arrayOfCards[i].name)))
                    {
                        arrayOfCards.removeAtIndex(i)
                        i--
                    }
                }
                
            }
            
        }
        
        //If this is first launch, disable buttons and show tutorial
        notfirstLaunch = NSUserDefaults.standardUserDefaults().boolForKey("FirstLaunch")
        if (!notfirstLaunch)
        {   self.navigationItem.rightBarButtonItem!.enabled = false
            backButton.enabled = false
            self.tableView.scrollEnabled = false
            
            self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TutorialPageViewController") as! TutorialPageViewController
            self.pageViewController.view.frame = CGRect(x: 0,y: 0, width:self.view.frame.width, height:self.view.frame.size.height)
            self.addChildViewController(self.pageViewController)
            self.view.addSubview(self.pageViewController.view)
            self.pageViewController.didMoveToParentViewController(self)
        }
        
        //Some categories have particular notes associated with them.  These are shown in page controllers
        //If tag is particular categories of algae, display note on category
        let chosenTag = jsonNavigator.orderOfNavigation.last
        if chosenTag == "filamentous mat-forming algae" || chosenTag == "cotton candy-like clouds of algae" || chosenTag == "algae that color the water"
        {
            let note = self.storyboard?.instantiateViewControllerWithIdentifier("NotePageViewController") as! NotePageViewController
            note.tag = chosenTag!
            note.view.frame = CGRect(x: 0,y: 0, width:self.view.frame.width, height:self.view.frame.size.height)
            
            self.addChildViewController(note)
            self.view.addSubview(note.view)
            note.didMoveToParentViewController(self)
        }
    }
    
    
    //Remove page controller and enable buttons when tutorial is done.
    func endTutorial()
    {
        self.pageViewController.willMoveToParentViewController(nil)
        self.pageViewController.view.removeFromSuperview()
        self.pageViewController.removeFromParentViewController()
        self.tableView.scrollEnabled = true
        self.navigationItem.rightBarButtonItem!.enabled = true
        backButton.enabled = true
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FirstLaunch")
    
    }
    
    //Pop view controller and regress json search when back is pressed
    @IBAction func back(sender: AnyObject) {
        
        if(self.title != "Home" )
        {
            SortThread.getSortThread().back()
            if(jsonNavigator.orderOfNavigation.count != 0)
            {
                jsonNavigator.regress()
            }
            
            
        }
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    //Regress json to start and pop view controllers
    func goHome()
    {
        let switchViewController = self.navigationController?.viewControllers[1] as! SpeciesTableViewController
        let times = jsonNavigator.orderOfNavigation.count
        switchViewController.jsonNavigator = JsonNavigator(json: jsonResponse())
        SortThread.getSortThread().resetMatches()
        
        //Regress the json tree search back to start
        for (var x = 0; x < times; x++)
        {
            jsonNavigator.regress()
        }
        self.navigationController?.popToViewController(switchViewController, animated: true)
        
    }
    
    //Pass jsonNavigator to next view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){

        if let destinationVC = segue.destinationViewController as? SpeciesTableViewController
        {
            destinationVC.jsonNavigator = jsonNavigator
        }
        
    }
    
   
    @IBOutlet weak var backButton: UIBarButtonItem!

    
    //Occurs when species / category card is pressed
    func pressed(sender: UIButton){

        jsonNavigator.updateCards()
        //If card leads to more categories or species
        if(jsonNavigator.pullSpecies == false)
        {
            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("SpeciesTableViewController") as! SpeciesTableViewController
            secondViewController.jsonNavigator = self.jsonNavigator
            secondViewController.jsonNavigator.advance(sender.titleLabel!.text!)
            SortThread.getSortThread().addToQueue(sender.titleLabel!.text!.lowercaseString)
            
            secondViewController.needToDisplayLocation = false
            
            if(locationPicked){
                
                secondViewController.locationPicked = true
                
            }
            
            self.navigationController!.pushViewController(secondViewController, animated: true)
            
        }
            //If card leads to one species
        else
        {
            
            let resultViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ResultViewController") as! ResultViewController
            resultViewController.jsonNavigator = self.jsonNavigator
            resultViewController.selectedSpeciesName = sender.titleLabel!.text!.lowercaseString
            
            var speciesArray = SortThread.getSortThread().retrieveMatches()
            
            //Searches through matches array for the species that pairs with the title of the button and sets the species object in the resultViewController equal to the match.
            
            for(var index: Int = 0; index < speciesArray.count; index++){
                
                if(speciesArray[index].name.lowercaseString == sender.titleLabel!.text!.lowercaseString)
                {
                    resultViewController.species = speciesArray[index]
                  
                }
                
        }
        self.navigationController!.pushViewController(resultViewController, animated: true)
        }

    }
    
    
    
    
   
    
    
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
     override func numberOfSectionsInTableView(tableView: UITableView) -> Int
     {
        
        return 1
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        
        
        
        
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
        navigationController!.navigationBar.barTintColor = UIColor(red:0.07, green:0.24, blue:0.07, alpha:1.0)
        
        //handles titles and appearance of buttons
        //Determine nav bar icons to use based on page type
        if(!(jsonNavigator.orderOfNavigation.count == 0 ))
        {
            
            self.title = jsonNavigator.orderOfNavigation.last?.capitalizedString
            self.navigationItem.setRightBarButtonItem(homeButton, animated: false)
        }
        else{
            
            if(locationPicked == true)
            {
                
                self.title = jsonNavigator.orderOfNavigation.last?.capitalizedString
                self.navigationItem.setRightBarButtonItem(homeButton, animated: false)
                title = pickedLocation
                
            }
            else
            {

                let p1 = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + "abt", ofType: "png")
                var i = UIImage()
                if(p1 != nil)
                {
                    i = UIImage(contentsOfFile: p1!)!
                }
                //Resize image
                let newSize = CGSize(width: 15, height: 15)
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
                info.tintColor = UIColor(red:0.89, green:0.90, blue:0.89, alpha:1.0)
                info.image = newImage
                    self.navigationItem.rightBarButtonItem = info
                self.title = "Home"
            }
        }
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        self.tableView.reloadData()

    }
    
    //Return number of cards as number of rows (+1 for browse button)
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        jsonNavigator.updateCards()
        return arrayOfCards.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //Get # of cells in tableview
        let maxRows = tableView.numberOfRowsInSection(0)
        
        //If cell is not last
        if(indexPath.item != (maxRows - 1))
        {
            
            let cellIdentifier = "tableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TableViewCell
            let cellButton = cell.speciesUIButton
            
            cellButton.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
            //Fetches the appropriate species for the data source layout.
            cell.buttonView.layer.shadowColor = UIColor.blackColor().CGColor
                        cell.buttonView.layer.shadowOffset = CGSizeMake(0, 4)
                        cell.buttonView.layer.shadowRadius = 5
                        cell.buttonView.layer.shadowOpacity = 1.0
                        cell.buttonView.layer.masksToBounds = false
            jsonNavigator.updateCards()
            let thisCard = arrayOfCards[indexPath.row]
            thisCard.name = thisCard.name.capitalizedString
            
            //Create title label for species / category
            let attributedString = NSMutableAttributedString(string: thisCard.name)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSRange(location: 0, length: attributedString.length))
            cellButton.titleLabel!.frame = CGRectMake(0, 20, cellButton.frame.width, 20)
            cellButton.setTitle(thisCard.name, forState: .Normal)
           
            //Adjust button size based on device size
            let wantedwidth = self.view.frame.width - 34
            let scale = wantedwidth/341
            
            let h = cell.speciesImageView.frame.height
            var k = cell.speciesUIButton.titleEdgeInsets
            if !(h == 223)
            {
               
                    cell.buttonBottomY.constant = scale*11
                    k.bottom = 223 - h
                
            }
            else
            {
                k.bottom = 0
            }
            cell.buttonY.constant = 0
            cell.speciesUIButton.titleEdgeInsets = k
            cell.speciesUIButton.titleLabel!.text = thisCard.name
            
            //Color button based on species invasive status
            if(thisCard.invasive == true)
            {
                cell.buttonView.backgroundColor = UIColor(red: 0.5, green: 0, blue: 0, alpha: 1)
            }
            else
            {
                cell.buttonView.backgroundColor = UIColor(red: 0.196, green: 0.322, blue: 0.196, alpha: 1)
            }
            cell.speciesUIButton.titleLabel!.textAlignment = .Center
            
            //Get species / category image
            var parsedImageName = thisCard.pictureName.componentsSeparatedByString(".")
            let newImageName: String = parsedImageName[0] as String
            let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + newImageName, ofType: "jpg")
            var image = UIImage()
            if(path != nil)
            {
                image = UIImage(contentsOfFile: path!)!
            }
            cell.speciesImageView.image = image
            
            //Add text to first cell on home page
            if (title == "Home" && indexPath.row == 0)
            {
                
                let speciesLabel = UILabel(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 40))
                speciesLabel.backgroundColor = UIColor(white: 1, alpha: 0)
                let attributes = [NSForegroundColorAttributeName: UIColor(red: 0, green: 40/255, blue: 0, alpha: 1.0),  NSFontAttributeName: UIFont(name: "Arial-BoldItalicMT", size: 17.0)!]
                let finalString = NSMutableAttributedString(string: "Browse Aquatic Phenomena by Type", attributes: attributes)
                speciesLabel.attributedText = finalString
                speciesLabel.textAlignment = NSTextAlignment.Center
                //Add space to top of cell for text
                cell.buttonY.constant = 40
                cell.imageY.constant = 40
                cell.addSubview(speciesLabel)
                k.bottom = 223 - h - 10
                cell.speciesUIButton.titleEdgeInsets = k
                
            }
            return cell
        }
        else    //If it is the last cell, it must be either the location cell on the home page or the browse cell
        {
            //If location cell
            if(needToDisplayLocation)
            {
                let cellIdentifier = "Location Cell"
                let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! LocationCell
                let cellButton = cell.locationButton
                cell.locationButtonView.layer.shadowColor = UIColor.blackColor().CGColor
                cell.locationButtonView.layer.shadowOffset = CGSizeMake(0, 4)
                cell.locationButtonView.layer.shadowRadius = 5
                cell.locationButtonView.layer.shadowOpacity = 1.0
                cell.locationButtonView.layer.masksToBounds = false
                
                //Add text and set up press function
                cellButton.addTarget(self, action: "pressedLocationButton:", forControlEvents: UIControlEvents.TouchUpInside)
                let speciesLabel = UILabel(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 40))
                speciesLabel.backgroundColor = UIColor(white: 1, alpha: 0)
                let attributes = [NSForegroundColorAttributeName: UIColor(red: 0, green: 40/255, blue: 0, alpha: 1.0),  NSFontAttributeName: UIFont(name: "Arial-BoldItalicMT", size: 17.0)!]
                let finalString = NSMutableAttributedString(string: "Or Browse by Location", attributes: attributes)
                speciesLabel.attributedText = finalString
                speciesLabel.textAlignment = NSTextAlignment.Center
                
                let attributes2 = [NSForegroundColorAttributeName: UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1.0),  NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 22.0)!]
                let finalString2 = NSMutableAttributedString(string: "Location", attributes: attributes2)
                cellButton.setAttributedTitle(finalString2, forState: .Normal)
                cellButton.titleEdgeInsets.bottom = (0 - cellButton.frame.height) + 40
                cell.addSubview(speciesLabel)
                
                return cell
            }
            //Otherwise it must be a browse cell
            else
            {
                let cellIdentifier = "Browse Cell"
                let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BrowseTableViewCell
                cell.browseButton.addTarget(self, action: "pressedBrowse:", forControlEvents: UIControlEvents.TouchUpInside)
                return cell
                
            }
            
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let width = self.view.frame.width - 34
        let scale = width/341
        
        let locationHeight = 357*scale
        //Give extra room to first and last cells on home page for text
        if ((title == "Home") && ((indexPath.item == 0) || (indexPath.item == 3)))
        {
            if (indexPath.row < heights.count)
            {
            return heights[indexPath.row] + 130
            }
            else
            {
                return locationHeight
            }
        }
        else
        {   //Adjust cell height according to adjust values calculated earlier
            if (indexPath.row < heights.count)
            {
                return heights[indexPath.row] + 90
            }
            else
            {
                return locationHeight
            }

        }
    }

    
    
    func pressedBrowse(sender: UIButton)
    {
        //Send current category data to browse table view controller and go there
        let browseTableViewController = self.storyboard!.instantiateViewControllerWithIdentifier("BrowseTableViewController") as! BrowseTableViewController
        if let pt = jsonNavigator.orderOfNavigation.last?.capitalizedString
        {
            browseTableViewController.title = pt
        }
        browseTableViewController.jsonNavigator = jsonNavigator
        self.navigationController!.pushViewController(browseTableViewController, animated: true)

    }
    
    //Go to location view controller if location button is pressed
    @IBAction func pressedLocationButton(sender: UIButton) {
        
        let locationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LocationViewController") as! LocationViewController2
        
        self.navigationController!.pushViewController(locationViewController, animated: true)
        
    }
    
    
    //Keep device portrait
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    override func shouldAutorotate() -> Bool
    {
       return UIInterfaceOrientationIsLandscape(interfaceOrientation)
    }
    

    
}

