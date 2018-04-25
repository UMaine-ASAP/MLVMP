////
////  ViewController.swift
////  MLVMP- IOS Dylan and Jasper
////
////  Created by Dylan Landry and Jasper Sheehan on 6/15/15.
////  Copyright (c) 2015 Dylan Landry, Jasper Sheehan. All rights reserved.
////
//
import UIKit

class ViewController: UIViewController {
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//
//    @IBOutlet weak var info: UIBarButtonItem!
//    @IBOutlet weak var headerBar: UINavigationItem!
//    @IBOutlet weak var backButton: UIBarButtonItem!
//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var categoryContainer: UIView!
//    @IBOutlet weak var label: UILabel!
//    
//    var marginBetweenCategoryContainers = 20
//    var selectedCategory = [String]()
//    var rootDictionary = [String : AnyObject]()
//    var currentDictionary = [String : AnyObject]()
//    var categoryContainerWidth : Int = 300
//    var categoryContainerHeight : Int = 100
//    var categoryHeight = 0
//    var pictureCategoryContainerHeight : Int = 275
//    var imageDip = [String : AnyObject]()
//    var debugImageName : String = ""
//    var firstTime = true
//    var newCategoryContainer: UIView?
//    var matches = [Species]()
//    var displayedLocationCategory: Bool = false
//    var locationPicked: Bool = false
//    
////    
////    func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
////        let size = image.size
////        
////        let widthRatio  = targetSize.width  / image.size.width
////        let heightRatio = targetSize.height / image.size.height
////        
////        // Figure out what our orientation is, and use that to form the rectangle
////        var newSize: CGSize
////        if(widthRatio > heightRatio) {
////            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
////        } else {
////            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
////        }
////        
////        // This is the rect that we've calculated out and this is what is actually used below
////        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
////        
////        // Actually do the resizing to the rect using the ImageContext stuff
////        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
////        image.drawInRect(rect)
////        let newImage = UIGraphicsGetImageFromCurrentImageContext()
////        UIGraphicsEndImageContext()
////        
////        return newImage
////    }
////    
////    //Function to handle parsing of JSON files
//    func jsonResponse() -> [String : AnyObject] {
//        let path = NSBundle.mainBundle().pathForResource("searchTree(complete)", ofType: "json")
//        let data = NSData(contentsOfFile: path!, options: NSDataReadingOptions.DataReadingUncached, error: nil)
//        let json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil)
//        return json as! [String : AnyObject]
//    }
////
////    //this function presents the photo to a UIView and sends it to fullScreenPic as a UIImageView
////    func tappedMe(sender: UITapGestureRecognizer){
////        
////        var imageView = sender.view as! UIImageView
////        var image = imageView.image
////        let vc : FullPicture = self.storyboard!.instantiateViewControllerWithIdentifier("fullScreenPic") as! FullPicture
////        vc.setUIImage(image!)
////        self.showViewController(vc as UIViewController, sender: vc)
////    }
////    
////    //allows images to be clicked?
////    override func canBecomeFirstResponder() -> Bool {
////        return true;
////    }
////    
////    //just a function to clean up when the backbutton is to appear or not
////    func backButtonToggle(mode: Bool){
////        if mode == true{
////            backButton.enabled = true;
////            backButton.title = "Back";
////        }
////        else{
////            backButton.enabled = false;
////            backButton.title = "";
////        }
////    }
////    
////    //MARK: GoBack
////    func goBack(){ //handles all back button events including title change and repopulation
////        //if when we start this func    tion, we are coming from category 1, remove the backbutton as we will now be in root (after goBack executes)
////        if(selectedCategory.count == 1){
////            backButtonToggle(false)
////            info.enabled = true;
////            info.title = "Info";
////            headerBar.title = "Home"
////        }
////        
////        
////        SortThread.getSortThread().back(selectedCategory.last!)
////        selectedCategory.removeLast()
////        currentDictionary.removeAll(keepCapacity: false)
////        
////        //as long as we aren't home, make sure the title updates
////        if(headerBar.title != "Home"){
////            headerBar.title = selectedCategory.last?.capitalizedString
////        }
////        
////        var subViews = self.scrollView.subviews
////    
////        for subview in subViews{
////            subview.removeFromSuperview()
////        }
////        
////        
////        
////        for (var index : Int = 0; index < selectedCategory.count; index++){
////            
////            if(index == 0){
////                currentDictionary  = rootDictionary[selectedCategory[index]] as! [String : AnyObject]
////            }
////            
////            if(index > 0){
////                currentDictionary  = currentDictionary[selectedCategory[index]] as! [String : AnyObject]
////            }
////        }
////        
////        //if the dictionary wasn't refilled after being wiped, we are at root and it should pull in the categorys
////        if(currentDictionary.count==0){
////            rootDictionary = jsonResponse()
////            currentDictionary = rootDictionary
////        }
////    
////        if(currentDictionary.keys.array.count == 1){
////            
////            createResultsView()
////            
////        }else{
////            
////            createViews(currentDictionary)
////        }
////        
////    }
////    
////    
////    func pressedResult(sender: UIButton!){
////        backButtonToggle(true)
////        self.selectedCategory.append(sender.titleLabel!.text!)
////        var subViews = self.scrollView.subviews
////        headerBar.title = sender.titleLabel!.text!.capitalizedString
////        //Deletes subviews.
////        for subview in subViews{
////            subview.removeFromSuperview()
////        }
////        
////        info.enabled = false;
////        info.title = "";
////        
////        
////        for(var index: Int = 0; index < matches.count; index++){
////            
////            
////            if (matches[index].name == sender.titleLabel!.text!.capitalizedString){
////                createResultView(matches[index])
////            }
////        }
////    }
////
////    
////    func pressedLocation(sender: UIButton!){
////    
////        displayedLocationCategory = true
////        
////        var possibleLocations = [String]()
////        possibleLocations.append("bottom")
////        possibleLocations.append("shallow")
////        possibleLocations.append("deep")
////        possibleLocations.append("surface")
////        possibleLocations.append("shoreline")
////        
////        for(var index: Int = 0; index < possibleLocations.count; index++){
////            
////            newCategoryContainer = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(categoryContainer)) as? UIView
////            scrollView.addSubview(newCategoryContainer!)
////            
////            //Method of creating constraints.
////            var constX:NSLayoutConstraint = NSLayoutConstraint(item: newCategoryContainer!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: categoryContainer, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0);
////            //Applys the constraint. Must apply to the superview (parent view) of the item you are manipulating.
////            scrollView.addConstraint(constX);
////            
////            //Method of creating constraints.
////            var constY:NSLayoutConstraint = NSLayoutConstraint(item: newCategoryContainer!, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: categoryContainer, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: ((categoryContainer.frame.height + CGFloat(marginBetweenCategoryContainers)) * (CGFloat(index))));
////            //Applys the constraint. Must apply to the superview (parent view) of the item you are manipulating.
////            scrollView.addConstraint(constY);
////            
////            //Makes label
////            var label = UILabel(frame: CGRectMake(0, 0, newCategoryContainer!.frame.size.width, newCategoryContainer!.frame.size.height))
////            label.textAlignment = NSTextAlignment.Center
////            label.text = possibleLocations[index].capitalizedString
////            label.font = UIFont(name: label.font.fontName, size: 25)
////            label.textColor=UIColor(red:0.773, green:0.745, blue:0.675, alpha:1)
////            newCategoryContainer!.addSubview(label)
////            
////            //Makes button.
////            let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
////            //Adds the button to the newCategoryContainer.
////            newCategoryContainer!.addSubview(button)
////            //Creates the button's frame, (position and size) through making a CGRect. Position is relative to superview.
////            button.frame = CGRectMake(0,0, newCategoryContainer!.frame.size.width, newCategoryContainer!.frame.size.height)
////            button.setTitle(possibleLocations[index], forState: UIControlState.Normal)
////            button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.0), forState: UIControlState.Normal)
////            //Executes funcion "pressed".
////            button.addTarget(self, action: "enteredLocation:", forControlEvents: UIControlEvents.TouchUpInside)
////            
////            scrollView.contentSize.height += CGFloat(categoryContainer.frame.height) + CGFloat(marginBetweenCategoryContainers)
////            
////            
////
////            
////        }
////        
////    }
////    
////    func enteredLocation(sender: UIButton!){
////        
////        SortThread.getSortThread().addToQueue(sender.titleLabel!.text!)
////        locationPicked = true
////        rootDictionary = jsonResponse()
////        currentDictionary = rootDictionary
////        createViews(currentDictionary)
////    
////    
////        
////    }
////    
////    //MARK: Pressed
////    func pressed(sender: UIButton!) { //handles all button presses (aside from the back and info buttons)
////        
////        
////        backButtonToggle(true)
////        self.selectedCategory.append(sender.titleLabel!.text!)
////        var subViews = self.scrollView.subviews
////        headerBar.title = sender.titleLabel!.text!.capitalizedString
////        
////        SortThread.getSortThread().addToQueue(sender.titleLabel!.text!)
////
////        for subview in subViews{
////            subview.removeFromSuperview()
////        }
////        
////        for (var index : Int = 0; index < selectedCategory.count; index++){
////            
////            if(index == 0){
////                currentDictionary  = rootDictionary[selectedCategory[index]] as! [String : AnyObject]
////            }
////            
////            if(index > 0){
////                currentDictionary  = currentDictionary[selectedCategory[index]] as! [String : AnyObject]
////            }
////        }
////        
////        
////        //get rid of the info button
////
////        info.enabled = false;
////        info.title = "";
////        
////        if(currentDictionary.keys.array.count == 1){
////           
////            createResultsView()
////        
////        }else{
////            createViews(currentDictionary)
////        }
////    }
////    
////    //MARK: createResultView
////    
////    func createResultView(chosenSpecies: Species){
////        println("Final Result: \(chosenSpecies.name)")
////        scrollView.contentSize.height = 0
////        
////        var pictureMargin: CGFloat = 20
////        var leftMargin: CGFloat = ((scrollView.frame.size.width - CGFloat(categoryContainerWidth))/2) + 2
////        var wordIndent: CGFloat = 3
////        var pictureHeight: CGFloat = 275
////        var pictureWidth: CGFloat = 298
////        var informationHeaderHeight: CGFloat = 19
////        var informationBlockHeight: CGFloat = 30
////        var informationBlockMargin: CGFloat = 15
////        var informationHeight: CGFloat = 18
////        var spacingValue: CGFloat = 0
////        var smallMargin: CGFloat = 10
////        var headerTextSize: CGFloat = 16
////        var informationTextSize: CGFloat = 16
////        var listSpacer: CGFloat = 6
////        
////        
////        //Picture container
////        var pictureContainer : UIView = UIView(frame: CGRectMake(leftMargin, CGFloat(pictureMargin), pictureWidth, CGFloat(pictureHeight)))
////        pictureContainer.backgroundColor = UIColor(red: 0.553, green: 0.502, blue: 0.384, alpha: 1)
////        scrollView.addSubview(pictureContainer)
////        scrollView.contentSize.height += CGFloat(categoryHeight + marginBetweenCategoryContainers)
////        spacingValue += pictureHeight + pictureMargin + 7
////        
////        //Picture
////        var imageName = chosenSpecies.pictures![0]
////        println()
////        
////        
////        println("THE IMAGENAME IS \(imageName)")
////        var parsedImageName = imageName.componentsSeparatedByString(".")
////        //First index (0) would be the name of the species while the second (1) is the file type extension.
////        var newImageName: String = parsedImageName[0] as String
////        let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + newImageName, ofType: "jpg")
////        //let path = NSBundle.mainBundle().pathForResource("species JSON files (updated/" + location, ofType: "json")
////        println("THE PATH IS \(path) ")
////        var image = UIImage()
////        if(path != nil){
////            image = UIImage(contentsOfFile: path!)!
////        }
////
////        
////        var imageView = UIImageView(image: image)
////        
////        var previousPictureContainerHeight = pictureContainer.frame.height
////        var croppedRect = pictureContainer.frame
////        
////        if(imageView.frame.width > pictureContainer.frame.width){
////            croppedRect = CGRectMake(0, 0, imageView.frame.width - (imageView.frame.width - pictureContainer.frame.width), imageView.frame.height - (imageView.frame.height*((imageView.frame.width - pictureContainer.frame.width)/imageView.frame.width)))
////            imageView.frame = croppedRect
////            pictureContainer.frame = CGRectMake(pictureContainer.frame.origin.x, pictureContainer.frame.origin.y, imageView.frame.width, imageView.frame.height)
////            spacingValue -= (previousPictureContainerHeight - pictureContainer.frame.height )
////            scrollView.contentSize.height -= (previousPictureContainerHeight - pictureContainer.frame.height )
////        }
////        
////        if(imageView.frame.height > pictureContainer.frame.height){
////            
////            croppedRect = CGRectMake((pictureContainer.frame.width - (imageView.frame.width - (imageView.frame.width*((imageView.frame.height - pictureContainer.frame.height)/imageView.frame.height))))/2, 0, imageView.frame.width - (imageView.frame.width*((imageView.frame.height - pictureContainer.frame.height)/imageView.frame.height)), imageView.frame.height - (imageView.frame.height - pictureContainer.frame.height) )
////            
////            imageView.frame = croppedRect
////            pictureContainer.backgroundColor = UIColor(red: 0.553, green: 0.502, blue: 0.384, alpha: 0)
////            spacingValue -= (previousPictureContainerHeight - pictureContainer.frame.height )
////            scrollView.contentSize.height -= (previousPictureContainerHeight - pictureContainer.frame.height )
////            
////        }
////        
////       
////        
////        
////        pictureContainer.addSubview(imageView)
////        
////        
////        
////        
////        
////        
////        
////
////        
////        //Name
////        
////        //Header
////        var nameHeader = UILabel(frame: CGRectMake(leftMargin, spacingValue ,pictureContainer.frame.size.width, informationHeaderHeight))
////        nameHeader.textAlignment = NSTextAlignment.Left
////        nameHeader.font = UIFont(name: "HelveticaNeue-Regular", size: headerTextSize)
////        nameHeader.text = "Name"
////        nameHeader.textColor=UIColor(red:0.416, green:0.373, blue:0.251, alpha:1)
////        scrollView.addSubview(nameHeader)
////        spacingValue += nameHeader.frame.height
////        scrollView.contentSize.height += nameHeader.frame.height
////        
////        //Information
////        var nameLabel = UILabel(frame: CGRectMake(leftMargin, spacingValue ,pictureContainer.frame.size.width, CGFloat(informationBlockHeight)))
////        nameLabel.textAlignment = NSTextAlignment.Left
////        nameLabel.text = chosenSpecies.name
////        nameLabel.text = nameLabel.text!.capitalizedString
////        nameLabel.font = UIFont(name: "HelveticaNeue-Light", size: informationTextSize)
////        nameLabel.numberOfLines = 0
////        nameLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
////        scrollView.addSubview(nameLabel)
////        spacingValue +=  nameLabel.frame.height + informationBlockMargin
////        scrollView.contentSize.height += nameLabel.frame.height + informationBlockMargin
//        
//        //Scientific name
//        if(chosenSpecies.scientificName != nil){
//            
//        //Header
//        var scientificNameHeader = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue ,pictureContainer.frame.size.width, CGFloat(informationHeaderHeight)))
//        scientificNameHeader.textAlignment = NSTextAlignment.Left
//        scientificNameHeader.text = "Scientific Name"
//        scientificNameHeader.font = UIFont(name: "HelveticaNeue-Regular", size: headerTextSize)
//        scientificNameHeader.textColor=UIColor(red:0.416, green:0.373, blue:0.251, alpha:1)
//        scrollView.addSubview(scientificNameHeader)
//        spacingValue += scientificNameHeader.frame.height
//        scrollView.contentSize.height += scientificNameHeader.frame.height
//        
//        //Information
//        var scientificNameLabel = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue ,pictureContainer.frame.size.width, informationHeight))
//        scientificNameLabel.font = UIFont(name: "HelveticaNeue-Light", size: informationTextSize)
//        scientificNameLabel.textAlignment = NSTextAlignment.Left
//        scientificNameLabel.text = chosenSpecies.scientificName
//        scientificNameLabel.text = scientificNameLabel.text!.capitalizedString
//        scientificNameLabel.textColor=UIColor(red:0.0, green:0.0, blue:0.0, alpha:1)
//        scientificNameLabel.numberOfLines = 0
//        scientificNameLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        scrollView.addSubview(scientificNameLabel)
//        spacingValue += scientificNameLabel.frame.height + informationBlockMargin
//        scrollView.contentSize.height += scientificNameLabel.frame.height + informationBlockMargin
//        }
//        
//        //Other names
//        if(chosenSpecies.otherNames != nil){
//            
//            //Header
//            var otherNamesHeader = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue ,pictureContainer.frame.size.width, CGFloat(informationHeaderHeight)))
//            otherNamesHeader.textAlignment = NSTextAlignment.Left
//            otherNamesHeader.text = "Other Names"
//            otherNamesHeader.font = UIFont(name: "HelveticaNeue-Regular", size: headerTextSize)
//            otherNamesHeader.textColor=UIColor(red:0.416, green:0.373, blue:0.251, alpha:1)
//            scrollView.addSubview(otherNamesHeader)
//            spacingValue += otherNamesHeader.frame.height
//            scrollView.contentSize.height += otherNamesHeader.frame.height
//            
//            //Label(s)
//            for(var index: Int = 0; index < chosenSpecies.otherNames!.count; index++){
//                var otherNamesLabel = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue ,pictureContainer.frame.size.width, informationHeight))
//                otherNamesLabel.font = UIFont(name: "HelveticaNeue-Light", size: informationTextSize)
//                otherNamesLabel.textAlignment = NSTextAlignment.Left
//                otherNamesLabel.text = chosenSpecies.otherNames![index]
//                otherNamesLabel.text = otherNamesLabel.text!.capitalizedString
//                otherNamesLabel.textColor=UIColor(red:0.0, green:0.0, blue:0.0, alpha:1)
//                otherNamesLabel.numberOfLines = 0
//                otherNamesLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
//                scrollView.addSubview(otherNamesLabel)
//                spacingValue += otherNamesLabel.frame.height
//                scrollView.contentSize.height += otherNamesLabel.frame.height
//            }
//            
//            spacingValue += informationBlockMargin
//            scrollView.contentSize.height += informationBlockMargin
//        }
//        
//        //Family
//        
//        //Header
//        if(chosenSpecies.family != nil){
//            var familyHeader = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue ,pictureContainer.frame.size.width, CGFloat(informationHeaderHeight)))
//            familyHeader.textAlignment = NSTextAlignment.Left
//            familyHeader.text = "Family"
//            familyHeader.font = UIFont(name: "HelveticaNeue-Regular", size: headerTextSize)
//            familyHeader.textColor=UIColor(red:0.416, green:0.373, blue:0.251, alpha:1)
//            scrollView.addSubview(familyHeader)
//            spacingValue += familyHeader.frame.height
//            scrollView.contentSize.height += familyHeader.frame.height
//            
//            //Information
//            var familyLabel = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue ,pictureContainer.frame.size.width, informationHeight))
//            familyLabel.font = UIFont(name: "HelveticaNeue-Light", size: informationTextSize)
//            familyLabel.numberOfLines = 0
//            familyLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
//            familyLabel.textAlignment = NSTextAlignment.Left
//            familyLabel.text = chosenSpecies.family![0]
//            familyLabel.textColor=UIColor(red:0.0, green:0.0, blue:0.0, alpha:1)
//            scrollView.addSubview(familyLabel)
//            spacingValue += informationBlockMargin + familyLabel.frame.height
//            scrollView.contentSize.height += informationBlockMargin +  familyLabel.frame.height
//        
//        }
//        
//        //Header
//        if(chosenSpecies.identifyingCharacteristics?.count != 0){
//            var identifyingCharacteristicsHeader = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue ,pictureContainer.frame.size.width, CGFloat(informationHeaderHeight)))
//            identifyingCharacteristicsHeader.textAlignment = NSTextAlignment.Left
//            identifyingCharacteristicsHeader.text = "Identifying Characteristics"
//            identifyingCharacteristicsHeader.font = UIFont(name: "HelveticaNeue-Regular", size: headerTextSize)
//            identifyingCharacteristicsHeader.textColor=UIColor(red:0.416, green:0.373, blue:0.251, alpha:1)
//            scrollView.addSubview(identifyingCharacteristicsHeader)
//            spacingValue += identifyingCharacteristicsHeader.frame.height
//            scrollView.contentSize.height += identifyingCharacteristicsHeader.frame.height
//            
//            //Information
//            for(var index: Int = 0; index < chosenSpecies.identifyingCharacteristics?.count; index++){
//    
//                var maxSize: CGSize = CGSize(width: pictureContainer.frame.width, height: 100)
//                var maximumLabelSize: CGRect = (chosenSpecies.identifyingCharacteristics![index] as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
//                var identifyingCharacteristicsInformation = UILabel(frame: (CGRectMake(leftMargin + wordIndent, spacingValue, maximumLabelSize.width, maximumLabelSize.height)))
//                identifyingCharacteristicsInformation.font = UIFont(name: "HelveticaNeue-Light", size: informationTextSize)
//                identifyingCharacteristicsInformation.textAlignment = NSTextAlignment.Left
//                identifyingCharacteristicsInformation.text = chosenSpecies.identifyingCharacteristics![index]
//                identifyingCharacteristicsInformation.text?.append(Character("."))
//                identifyingCharacteristicsInformation.textColor=UIColor(red:0.0, green:0.0, blue:0.0, alpha:1)
//                identifyingCharacteristicsInformation.numberOfLines = 0
//                identifyingCharacteristicsInformation.lineBreakMode = NSLineBreakMode.ByWordWrapping
//                identifyingCharacteristicsInformation.preferredMaxLayoutWidth = pictureContainer.frame.width
//                scrollView.addSubview(identifyingCharacteristicsInformation)
//                spacingValue += identifyingCharacteristicsInformation.frame.height + listSpacer
//                scrollView.contentSize.height += identifyingCharacteristicsInformation.frame.height + listSpacer
//                
//            }
//            
//            spacingValue += informationBlockMargin
//            scrollView.contentSize.height += informationBlockMargin
//            
//        }
//        
//        //Header
//        if(chosenSpecies.biology?.count != 0 && chosenSpecies.biology != nil){
//            var biologyHeader = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue, pictureContainer.frame.size.width, CGFloat(informationHeaderHeight)))
//            biologyHeader.textAlignment = NSTextAlignment.Left
//            biologyHeader.text = "Biology"
//            biologyHeader.font = UIFont(name: "HelveticaNeue-Regular", size: headerTextSize)
//            biologyHeader.textColor=UIColor(red:0.416, green:0.373, blue:0.251, alpha:1)
//            scrollView.addSubview(biologyHeader)
//            spacingValue += biologyHeader.frame.height
//            scrollView.contentSize.height += biologyHeader.frame.height
//            
//            //Information
//            for(var index: Int = 0; index < chosenSpecies.biology!.count; index++){
//                
//                var maxSize: CGSize = CGSize(width: pictureContainer.frame.width, height: 100)
//                var maximumLabelSize: CGRect = (chosenSpecies.biology![index] as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
//                var biologyInformation = UILabel(frame: (CGRectMake(leftMargin + wordIndent, spacingValue, maximumLabelSize.width, maximumLabelSize.height)))
//                biologyInformation.font = UIFont(name: "HelveticaNeue-Light", size: informationTextSize)
//                biologyInformation.textAlignment = NSTextAlignment.Left
//                biologyInformation.text = chosenSpecies.biology![index]
//                biologyInformation.text?.append(Character("."))
//                biologyInformation.textColor=UIColor(red:0.0, green:0.0, blue:0.0, alpha:1)
//                biologyInformation.numberOfLines = 0
//                biologyInformation.lineBreakMode = NSLineBreakMode.ByWordWrapping
//                biologyInformation.preferredMaxLayoutWidth = pictureContainer.frame.width
//                scrollView.addSubview(biologyInformation)
//                spacingValue += biologyInformation.frame.height + listSpacer
//                scrollView.contentSize.height += biologyInformation.frame.height + listSpacer
//
//            }
//            
//            spacingValue += informationBlockMargin
//            scrollView.contentSize.height += informationBlockMargin
//            
//        }
//        
//        //Header
//        if(chosenSpecies.diet?.count != 0 && chosenSpecies.diet != nil){
//            var dietHeader = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue, pictureContainer.frame.size.width, CGFloat(informationHeaderHeight)))
//            dietHeader.textAlignment = NSTextAlignment.Left
//            dietHeader.text = "Diet"
//            dietHeader.font = UIFont(name: "HelveticaNeue-Regular", size: headerTextSize)
//            dietHeader.textColor=UIColor(red:0.416, green:0.373, blue:0.251, alpha:1)
//            scrollView.addSubview(dietHeader)
//            spacingValue += dietHeader.frame.height
//            scrollView.contentSize.height += dietHeader.frame.height
//            
//            //Information
//            for(var index: Int = 0; index < chosenSpecies.diet!.count; index++){
//                
//                var maxSize: CGSize = CGSize(width: pictureContainer.frame.width, height: 100)
//                var maximumLabelSize: CGRect = (chosenSpecies.diet![index] as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
//                var dietInformation = UILabel(frame: (CGRectMake(leftMargin + wordIndent, spacingValue, maximumLabelSize.width, maximumLabelSize.height)))
//                dietInformation.font = UIFont(name: "HelveticaNeue-Light", size: informationTextSize)
//                dietInformation.textAlignment = NSTextAlignment.Left
//                dietInformation.text = chosenSpecies.diet![index]
//                dietInformation.textColor=UIColor(red:0.0, green:0.0, blue:0.0, alpha:1)
//                dietInformation.numberOfLines = 0
//                dietInformation.lineBreakMode = NSLineBreakMode.ByWordWrapping
//                dietInformation.preferredMaxLayoutWidth = pictureContainer.frame.width
//                scrollView.addSubview(dietInformation)
//                spacingValue += dietInformation.frame.height + listSpacer
//                scrollView.contentSize.height += dietInformation.frame.height + listSpacer
//                
//            }
//            
//            spacingValue += informationBlockMargin
//            scrollView.contentSize.height += informationBlockMargin
//            
//        }
//        
//        //Header
//        if(chosenSpecies.habitat?.count != 0 && chosenSpecies.habitat != nil){
//            var habitatHeader = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue, pictureContainer.frame.size.width, CGFloat(informationHeaderHeight)))
//            habitatHeader.textAlignment = NSTextAlignment.Left
//            habitatHeader.text = "Habitat"
//            habitatHeader.font = UIFont(name: "HelveticaNeue-Regular", size: headerTextSize)
//            habitatHeader.textColor=UIColor(red:0.416, green:0.373, blue:0.251, alpha:1)
//            scrollView.addSubview(habitatHeader)
//            spacingValue += habitatHeader.frame.height
//            scrollView.contentSize.height += habitatHeader.frame.height
//            
//            //Information
//            for(var index: Int = 0; index < chosenSpecies.habitat!.count; index++){
//                
//                var maxSize: CGSize = CGSize(width: pictureContainer.frame.width, height: 100)
//                var maximumLabelSize: CGRect = (chosenSpecies.habitat![index] as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
//                var habitatInformation = UILabel(frame: (CGRectMake(leftMargin + wordIndent, spacingValue, maximumLabelSize.width, maximumLabelSize.height)))
//                habitatInformation.font = UIFont(name: "HelveticaNeue-Light", size: informationTextSize)
//                habitatInformation.textAlignment = NSTextAlignment.Left
//                habitatInformation.text = chosenSpecies.habitat![index]
//                habitatInformation.textColor=UIColor(red:0.0, green:0.0, blue:0.0, alpha:1)
//                habitatInformation.numberOfLines = 0
//                habitatInformation.lineBreakMode = NSLineBreakMode.ByWordWrapping
//                habitatInformation.preferredMaxLayoutWidth = pictureContainer.frame.width
//                scrollView.addSubview(habitatInformation)
//                spacingValue += habitatInformation.frame.height + listSpacer
//                scrollView.contentSize.height += habitatInformation.frame.height + listSpacer
//                
//            }
//            
//            spacingValue += informationBlockMargin
//            scrollView.contentSize.height += informationBlockMargin
//            
//        }
//
//
//        
//        //Header
//        
//        if(chosenSpecies.lookAlikes?.count != 0 && chosenSpecies.lookAlikes != nil){
//            var lookAlikesHeader = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue, pictureContainer.frame.size.width, CGFloat(informationHeaderHeight)))
//            lookAlikesHeader.textAlignment = NSTextAlignment.Left
//            lookAlikesHeader.text = "Look Alikes"
//            lookAlikesHeader.font = UIFont(name: "HelveticaNeue-Regular", size: headerTextSize)
//            lookAlikesHeader.textColor=UIColor(red:0.416, green:0.373, blue:0.251, alpha:1)
//            scrollView.addSubview(lookAlikesHeader)
//            spacingValue += lookAlikesHeader.frame.height
//            scrollView.contentSize.height += lookAlikesHeader.frame.height
//            
//            //Information
//            for(var index: Int = 0; index < chosenSpecies.lookAlikes!.count; index++){
//                
//                var maxSize: CGSize = CGSize(width: pictureContainer.frame.width, height: 100)
//                var maximumLabelSize: CGRect = (chosenSpecies.lookAlikes![index] as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
//                var lookAlikesInformation = UILabel(frame: (CGRectMake(leftMargin + wordIndent, spacingValue, maximumLabelSize.width, maximumLabelSize.height)))
//                lookAlikesInformation.font = UIFont(name: "HelveticaNeue-Light", size: informationTextSize)
//                lookAlikesInformation.textAlignment = NSTextAlignment.Left
//                lookAlikesInformation.text = chosenSpecies.lookAlikes![index]
//                lookAlikesInformation.textColor=UIColor(red:0.0, green:0.0, blue:0.0, alpha:1)
//                lookAlikesInformation.numberOfLines = 0
//                lookAlikesInformation.lineBreakMode = NSLineBreakMode.ByWordWrapping
//                lookAlikesInformation.preferredMaxLayoutWidth = pictureContainer.frame.width
//                scrollView.addSubview(lookAlikesInformation)
//                spacingValue += lookAlikesInformation.frame.height + listSpacer
//                scrollView.contentSize.height += lookAlikesInformation.frame.height + listSpacer
//                
//            }
//            
//            spacingValue += informationBlockMargin
//            scrollView.contentSize.height += informationBlockMargin
//            
//        }
//
//        if(chosenSpecies.commonlySeen?.count != 0 && chosenSpecies.commonlySeen != nil){
//            var commonlySeenHeader = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue, pictureContainer.frame.size.width, CGFloat(informationHeaderHeight)))
//            commonlySeenHeader.textAlignment = NSTextAlignment.Left
//            commonlySeenHeader.text = "Commonly Seen"
//            commonlySeenHeader.font = UIFont(name: "HelveticaNeue-Regular", size: headerTextSize)
//            commonlySeenHeader.textColor=UIColor(red:0.416, green:0.373, blue:0.251, alpha:1)
//            scrollView.addSubview(commonlySeenHeader)
//            spacingValue += commonlySeenHeader.frame.height
//            scrollView.contentSize.height += commonlySeenHeader.frame.height
//            
//            //Information
//            for(var index: Int = 0; index < chosenSpecies.commonlySeen!.count; index++){
//                
//                var maxSize: CGSize = CGSize(width: pictureContainer.frame.width, height: 100)
//                var maximumLabelSize: CGRect = (chosenSpecies.commonlySeen![index] as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
//                var commonlySeenInformation = UILabel(frame: (CGRectMake(leftMargin + wordIndent, spacingValue, maximumLabelSize.width, maximumLabelSize.height)))
//                commonlySeenInformation.font = UIFont(name: "HelveticaNeue-Light", size: informationTextSize)
//                commonlySeenInformation.textAlignment = NSTextAlignment.Left
//                commonlySeenInformation.text = chosenSpecies.commonlySeen![index]
//                commonlySeenInformation.textColor=UIColor(red:0.0, green:0.0, blue:0.0, alpha:1)
//                commonlySeenInformation.numberOfLines = 0
//                commonlySeenInformation.lineBreakMode = NSLineBreakMode.ByWordWrapping
//                commonlySeenInformation.preferredMaxLayoutWidth = pictureContainer.frame.width
//                scrollView.addSubview(commonlySeenInformation)
//                spacingValue += commonlySeenInformation.frame.height + listSpacer
//                scrollView.contentSize.height += commonlySeenInformation.frame.height + listSpacer
//                
//            }
//            
//            spacingValue += informationBlockMargin
//            scrollView.contentSize.height += informationBlockMargin
//            
//        }
//        
//        if(chosenSpecies.range?.count != 0 && chosenSpecies.range != nil){
//            var rangeHeader = UILabel(frame: CGRectMake(leftMargin + wordIndent, spacingValue, pictureContainer.frame.size.width, CGFloat(informationHeaderHeight)))
//            rangeHeader.textAlignment = NSTextAlignment.Left
//            rangeHeader.text = "Range"
//            rangeHeader.font = UIFont(name: "HelveticaNeue-Regular", size: headerTextSize)
//            rangeHeader.textColor=UIColor(red:0.416, green:0.373, blue:0.251, alpha:1)
//            scrollView.addSubview(rangeHeader)
//            spacingValue += rangeHeader.frame.height
//            scrollView.contentSize.height += rangeHeader.frame.height
//            
//            //Information
//            for(var index: Int = 0; index < chosenSpecies.range!.count; index++){
//                
//                var maxSize: CGSize = CGSize(width: pictureContainer.frame.width, height: 100)
//                var maximumLabelSize: CGRect = (chosenSpecies.range![index] as NSString).boundingRectWithSize(maxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
//                var rangeInformation = UILabel(frame: (CGRectMake(leftMargin + wordIndent, spacingValue, maximumLabelSize.width, maximumLabelSize.height)))
//                rangeInformation.font = UIFont(name: "HelveticaNeue-Light", size: informationTextSize)
//                rangeInformation.textAlignment = NSTextAlignment.Left
//                rangeInformation.text = chosenSpecies.range![index]
//                rangeInformation.textColor=UIColor(red:0.0, green:0.0, blue:0.0, alpha:1)
//                rangeInformation.numberOfLines = 0
//                rangeInformation.lineBreakMode = NSLineBreakMode.ByWordWrapping
//                rangeInformation.preferredMaxLayoutWidth = pictureContainer.frame.width
//                scrollView.addSubview(rangeInformation)
//                spacingValue += rangeInformation.frame.height + listSpacer
//                scrollView.contentSize.height += rangeInformation.frame.height + listSpacer
//                
//            }
//            
//            spacingValue += informationBlockMargin
//            scrollView.contentSize.height += informationBlockMargin
//            
//        }
//
//
//        
//        
//        
//        
//        
//    }
//    
//    //MARK: createResultsView
//    
//    func createResultsView(){
//        //SortThread.getSortThread().back(selectedCategory.last!)
//        matches = SortThread.getSortThread().retrieveMatches()
//        //matches = SortThread.globalSortThread!.retreiveMatches()
//        println("____________")
//        println("\(matches.count) Results. |")
//        println("------------")
//        println()
//        
//        scrollView.contentSize.height = 0;
//        var spacingCounter: Int = 0
//        for(var index: Int = 0; index < matches.count; index++){
//            
//            //UIView
//            var newPictureCategoryContainer : UIView = UIView(frame: CGRectMake(((scrollView.frame.size.width - CGFloat(categoryContainerWidth))/2), ((CGFloat(spacingCounter) * CGFloat(categoryHeight + marginBetweenCategoryContainers)) + CGFloat(marginBetweenCategoryContainers)), 300, CGFloat(categoryHeight)))
//            newPictureCategoryContainer.backgroundColor = UIColor(red: 0.553, green: 0.502, blue: 0.384, alpha: 1)
//            scrollView.addSubview(newPictureCategoryContainer)
//            scrollView.contentSize.height += CGFloat(categoryHeight + marginBetweenCategoryContainers)
//            
//            //Picture
//            var imageName = matches[index].pictures![0]
//           
//            
//            println("THE IMAGENAME IS \(imageName)")
//            var parsedImageName = imageName.componentsSeparatedByString(".")
//            //First index (0) would be the name of the species while the second (1) is the file type extension.
//            var newImageName: String = parsedImageName[0] as String
//            let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + newImageName, ofType: "jpg")
//            //let path = NSBundle.mainBundle().pathForResource("species JSON files (updated/" + location, ofType: "json")
//            println("THE PATH IS \(path) ")
//            var image = UIImage()
//            if(path != nil){
//                image = UIImage(contentsOfFile: path!)!
//            }
//            
//            let imageView = UIImageView(image: image)
//            imageView.frame = CGRectMake(0, 0, newPictureCategoryContainer.frame.size.width, newPictureCategoryContainer.frame.size.height - CGFloat(categoryContainerHeight))
//            newPictureCategoryContainer.addSubview(imageView)
//            
//            //Label
//            var label = UILabel(frame: CGRectMake(CGFloat(0), CGFloat(0),CGFloat(newPictureCategoryContainer.frame.size.width), CGFloat(categoryHeight)))
//            label.textAlignment = NSTextAlignment.Center
//            label.center.y = CGFloat(5*(categoryHeight/6))
//            label.text = matches[index].name
//            label.text = label.text!.capitalizedString
//            label.font = UIFont(name: label.font.fontName, size: 25)
//            label.textColor=UIColor(red:0.773, green:0.745, blue:0.675, alpha:1)
//            label.numberOfLines = 0
//            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
//            newPictureCategoryContainer.addSubview(label)
//            
//            //Button
//            let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
//            newPictureCategoryContainer.addSubview(button)
//            
//            button.frame = CGRectMake(0,CGFloat(newPictureCategoryContainer.frame.size.height) - CGFloat(categoryContainerHeight), newPictureCategoryContainer.frame.size.width, newPictureCategoryContainer.frame.size.height - (CGFloat(newPictureCategoryContainer.frame.size.height) - CGFloat(categoryContainerHeight)))
//            button.setTitle(matches[index].name, forState: UIControlState.Normal)
//            button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.0), forState: UIControlState.Normal)
//            //Executes funcion "pressed".
//            button.addTarget(self, action: "pressedResult:", forControlEvents: UIControlEvents.TouchUpInside)
//            spacingCounter++
//            
//            //
//            
//        }
//    }
//    
//
    //MARK: View Did Appear
//    override func viewDidAppear(animated: Bool) {

//        super.viewDidAppear(true)
//        backButton.target = self
//        backButton.action = "goBack"
//        backButtonToggle(false)
//        headerBar.title = "Home"
//
//        var sortThread = SortThread.getSortThread()
//        sortThread.getThread().start()
//            
//        
//        // Returns entire json tree as dictionary of strings
//        
//        rootDictionary = jsonResponse()
//        currentDictionary = rootDictionary
//        
//        
//        
//        //Populates Fauna, Physical Curiosities, Flora, and Location (+1).
//        for(var i = 0; i < currentDictionary.keys.array.count + 1; i++){
//            //Unarchive and archived object to 'copy and paste' it.
//            
//        newCategoryContainer = NSKeyedUnarchiver.unarchiveObjectWithData(NSKeyedArchiver.archivedDataWithRootObject(categoryContainer)) as? UIView
//        scrollView.addSubview(newCategoryContainer!)
//            
//            if(i < 3){
//            
//            //Method of creating constraints.
//            var constX:NSLayoutConstraint = NSLayoutConstraint(item: newCategoryContainer!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: categoryContainer, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0);
//            //Applys the constraint. Must apply to the superview (parent view) of the item you are manipulating.
//            scrollView.addConstraint(constX);
//
//            //Method of creating constraints.
//            var constY:NSLayoutConstraint = NSLayoutConstraint(item: newCategoryContainer!, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: categoryContainer, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: ((categoryContainer.frame.height + CGFloat(marginBetweenCategoryContainers)) * (CGFloat(i))));
//            //Applys the constraint. Must apply to the superview (parent view) of the item you are manipulating.
//            scrollView.addConstraint(constY);
//            
//            //Makes label
//            var label = UILabel(frame: CGRectMake(0, 0, newCategoryContainer!.frame.size.width, newCategoryContainer!.frame.size.height))
//            label.textAlignment = NSTextAlignment.Center
//            label.text = currentDictionary.keys.array[i].capitalizedString
//            label.font = UIFont(name: label.font.fontName, size: 25)
//            label.textColor=UIColor(red:0.773, green:0.745, blue:0.675, alpha:1)
//            newCategoryContainer!.addSubview(label)
//            
//            //Makes button.
//            let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
//            //Adds the button to the newCategoryContainer.
//            newCategoryContainer!.addSubview(button)
//            //Creates the button's frame, (position and size) through making a CGRect. Position is relative to superview.
//            button.frame = CGRectMake(0,0, newCategoryContainer!.frame.size.width, newCategoryContainer!.frame.size.height)
//            button.setTitle(currentDictionary.keys.array[i], forState: UIControlState.Normal)
//            button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.0), forState: UIControlState.Normal)
//            //Executes funcion "pressed".
//            button.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
//            }else{
//                
//                //Location category
//                //Method of creating constraints.
//                var constX:NSLayoutConstraint = NSLayoutConstraint(item: newCategoryContainer!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: categoryContainer, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0);
//                //Applys the constraint. Must apply to the superview (parent view) of the item you are manipulating.
//                scrollView.addConstraint(constX);
//                
//                //Method of creating constraints.
//                var constY:NSLayoutConstraint = NSLayoutConstraint(item: newCategoryContainer!, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: categoryContainer, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: ((categoryContainer.frame.height + CGFloat(marginBetweenCategoryContainers)) * (CGFloat(i))));
//                //Applys the constraint. Must apply to the superview (parent view) of the item you are manipulating.
//                scrollView.addConstraint(constY);
//                
//                //Makes label
//                var label = UILabel(frame: CGRectMake(0, 0, newCategoryContainer!.frame.size.width, newCategoryContainer!.frame.size.height))
//                label.textAlignment = NSTextAlignment.Center
//                label.text = "Location"
//                label.font = UIFont(name: label.font.fontName, size: 25)
//                label.textColor=UIColor(red:0.773, green:0.745, blue:0.675, alpha:1)
//                newCategoryContainer!.addSubview(label)
//                
//                //Makes button.
//                let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
//                //Adds the button to the newCategoryContainer.
//                newCategoryContainer!.addSubview(button)
//                //Creates the button's frame, (position and size) through making a CGRect. Position is relative to superview.
//                button.frame = CGRectMake(0,0, newCategoryContainer!.frame.size.width, newCategoryContainer!.frame.size.height)
//                button.setTitle("Location", forState: UIControlState.Normal)
//                button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.0), forState: UIControlState.Normal)
//                //Executes funcion "pressed".
//                button.addTarget(self, action: "pressedLocation:", forControlEvents: UIControlEvents.TouchUpInside)
//                
//            }
//    firstTime = false
//   }
//}
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        println("[][][][][][][][][][][][][][][]")
//        println("[][][][]MEMORY WARNING[][][][]")
//        println("[][][][][][][][][][][][][][][]")
//    }
//    
//    
//    
//    //MARK: Create Views
//    func createViews(currentDictionary: [String : AnyObject]){ //populates the view on the current category
//        
//        var subViews = self.scrollView.subviews
//        
//        for subview in subViews{
//            subview.removeFromSuperview()
//        }
//
//        
//            scrollView.contentSize.height = 0;
//        var spacingCounter : Int = 0
//        
//        for (var index : Int = 0; index < currentDictionary.keys.array.count; index++){
//            
//            if(!(currentDictionary.keys.array[index] == "picture")){
//                
//                if (selectedCategory.count == 0){
//                    categoryHeight = categoryContai//nerHeight
//                    
//                }else{
//                    categoryHeight = pictureCategoryContainerHeight
//                }
//    
//        var newPictureCategoryContainer : UIView = UIView(frame: CGRectMake(((scrollView.frame.size.width - CGFloat(categoryContainerWidth))/2), ((CGFloat(spacingCounter) * CGFloat(categoryHeight + marginBetweenCategoryContainers)) + CGFloat(marginBetweenCategoryContainers)), 300, CGFloat(categoryHeight)))
//            newPictureCategoryContainer.backgroundColor = UIColor(red: 0.553, green: 0.502, blue: 0.384, alpha: 1)
//            scrollView.addSubview(newPictureCategoryContainer)
//            scrollView.contentSize.height += CGFloat(categoryHeight + marginBetweenCategoryContainers)
//                
//                if(selectedCategory.count > 0){
//                    backButtonToggle(true)
//                }
//            
//            if(selectedCategory.count>0){
//                imageDip  = currentDictionary[currentDictionary.keys.array[index]] as! [String : AnyObject]
//                var imageName = ""
//                if(!(imageDip["picture"]==nil)){
//                imageName = imageDip["picture"] as! String
//            }
//                
//                if(!(selectedCategory.count == 0)){
//                    //Make UIImage referencing imageName.
//                
//                    
////                    println("THE IMAGENAME IS \(imageName)")
//                    var parsedImageName = imageName.componentsSeparatedByString(".")
//            
//                    var newImageName: String = parsedImageName[0] as String
//                    let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + newImageName, ofType: "jpg")
//                    
////                    println("THE PATH IS \(path) ")
//                    var image = UIImage()
//                    if(path != nil){
//                        image = UIImage(contentsOfFile: path!)!
//                    }
//                    
//                    
//                    //Make UIImageView from UIImage.
//                    let imageView = UIImageView(image: image)
//                    
//                    // this is used for image tapping
//                    var tap = UITapGestureRecognizer(target: self, action: Selector("tappedMe:"))
//                    imageView.addGestureRecognizer(tap)
//                    imageView.userInteractionEnabled = true
//                    
//                    //Adds the UIImageView as a subview of newPictureCategoryContainer which contains it.
//                    newPictureCategoryContainer.addSubview(imageView)
//                    
//                    //---
//                    
//                    //Gives the UIImage view a background color.
//                    imageView.backgroundColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
//                    //Sets the frame sizes of UIImageView.
//                    imageView.frame = CGRectMake(0, 0, newPictureCategoryContainer.frame.size.width, newPictureCategoryContainer.frame.size.height - CGFloat(categoryContainerHeight))
//                    }
//                }
//
//            //Makes label
//            var label = UILabel(frame: CGRectMake(CGFloat(0), CGFloat(0),CGFloat(newPictureCategoryContainer.frame.size.width), CGFloat(categoryHeight)))
//            label.textAlignment = NSTextAlignment.Center
//                
//                if(categoryHeight == pictureCategoryContainerHeight){
//                    label.center.y = CGFloat(5*(categoryHeight/6))
//                    
//                }else{
//                    label.center.y = CGFloat(categoryHeight/2)
//                }
//                
//            label.text = currentDictionary.keys.array[index].capitalizedString
//            label.font = UIFont(name: label.font.fontName, size: 25)
//            label.textColor=UIColor(red:0.773, green:0.745, blue:0.675, alpha:1)
//            label.numberOfLines = 0
//            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
//            newPictureCategoryContainer.addSubview(label)
//        
//            //Makes button.
//            let button   = UIButton.buttonWithType(UIButtonType.System) as! UIButton
//            //Adds the button to the newCategoryContainer.
//            newPictureCategoryContainer.addSubview(button)
//            //Creates the button's frame, (position and size) through making a CGRect. Position is relative to superview.
//        
//            if(categoryHeight == pictureCategoryContainerHeight){
//                    button.frame = CGRectMake(0,CGFloat(newPictureCategoryContainer.frame.size.height) - CGFloat(categoryContainerHeight), newPictureCategoryContainer.frame.size.width, newPictureCategoryContainer.frame.size.height - (CGFloat(newPictureCategoryContainer.frame.size.height) - CGFloat(categoryContainerHeight)))
//            }else{
//                    button.frame = CGRectMake(0,0,newPictureCategoryContainer.frame.size.width, CGFloat(categoryContainerHeight))
//            }
//            button.setTitle(currentDictionary.keys.array[index], forState: UIControlState.Normal)
//            button.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.0), forState: UIControlState.Normal)
//            //Executes funcion "pressed".
//            button.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
//            spacingCounter++
//                
//            }
//        }
//    }
//}
//
