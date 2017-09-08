

//
//  BrowseTableViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by MIke Scott on 8/11/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

let reuseTableViewCellIdentifier = "TableViewCell"
let reuseCollectionViewCellIdentifier = "CollectionViewCell"

class BrowseTableViewController: UITableViewController
{
    var jsonNavigator: JsonNavigator = JsonNavigator(json: jsonResponse())
    var matches: [Species]!
    var sourceArray: NSMutableArray!
    var contentOffsetDictionary: NSMutableDictionary!
    var window: UIWindow?
    var root: UINavigationController?
    var darkGreen = UIColor(red: 0/255, green: 40/255, blue: 0/255, alpha: 1.0)
    var photoList = [String]()
    var photos = [[UIImage]]()

    override func viewDidLoad() {
        matches = SortThread.getSortThread().retrieveMatches()
       
        //On separate thread, go through all pictures of all species and put them in tableview
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0))
            {
                //Matches for other aquatic curiosities have certain order
                if self.title != "Other Aquatic Curiosities"
                {   self.matches.sortInPlace { return $0.name < $1.name}
                }
                //otherwise Get Matches and sort alphabetically
                else
                {
                    self.matches.sortInPlace { return $0.order < $1.order}
                }
                for var x = 0; x < self.matches.count; x++
                {   let s = self.matches[x]
                    if let pics = s.pictures
                    {   var picList = [UIImage]()
                        for var y = 0; y < pics.count; y++
                        {
                            let p = pics[y]
                            var parsedImageName = p.componentsSeparatedByString(".")
                            let newImageName: String = parsedImageName[0] as String
                            let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + newImageName, ofType: "jpg")
                            var image = UIImage()
                            let imageView = UIImageView()
                            imageView.frame = CGRectMake(0,0,91,91)
                            imageView.contentMode = UIViewContentMode.ScaleAspectFit
                            if (path != nil)
                            {
                                image = UIImage(contentsOfFile: path!)!
                            }
                            
                            //Resize image
                            let newSize = CGSize(width: 55, height: 55)
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
                                image = newImage
                                
                            }
                            else
                            {
                                imageView.image = UIImage(named: "fragrant_waterlily5")
                                
                            }
                            
                            picList.append(image)
                        }
                        self.photos.append(picList)
                        
                    }
                }
                
        }

        
        
        
        
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //Set up tableView
        self.tableView.registerClass(BrowseTableViewCell2.self, forCellReuseIdentifier: reuseTableViewCellIdentifier)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.contentOffsetDictionary = NSMutableDictionary()
        tableView.backgroundColor = UIColor(red: 0.792, green: 0.769, blue: 0.694, alpha: 1)
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        
        let numberOfTableViewRows: NSInteger = matches.count            //Number of species = number of rows
        let numberOfCollectionViewCells: NSInteger = 20                 //Max number of pictures for each species
        
        
        let speciesArray = NSMutableArray(capacity: numberOfCollectionViewCells)
        for var tableViewRow = 0; tableViewRow < numberOfTableViewRows; ++tableViewRow
        {                                                               //Loops through species and creates array of arrays containing species pictures
            let pictureArray: NSMutableArray = NSMutableArray(capacity: numberOfCollectionViewCells)
            for var collectionViewItem = 0; collectionViewItem < matches[tableViewRow].pictures!.count; ++collectionViewItem
            {
                pictureArray.addObject(matches[tableViewRow].pictures![collectionViewItem])
            }
            speciesArray .addObject(pictureArray)
        }
        //Create Navigation items
        let homeButton = UIBarButtonItem(title: "Home", style: .Plain , target: self, action: "goHome")
        homeButton.tintColor = UIColor.whiteColor()
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
                self.sourceArray = speciesArray
        
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
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
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    override func shouldAutorotate() -> Bool {
        return UIInterfaceOrientationIsLandscape(interfaceOrientation)

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
        let homeButton = UIBarButtonItem(title: "", style: .Plain , target: self, action: "goHome")
        
        let p2 = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + "home1", ofType: "png")
        var i = UIImage()
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
        let newImageRef = CGBitmapContextCreateImage(context!)! as CGImage
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
}

//
// MARK: - Table view data source
//
//
//
extension BrowseTableViewController
{
    //Returns # of table rows
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {return self.sourceArray.count}
    
    //Generates cell and corresponding label
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = (tableView.dequeueReusableCellWithIdentifier(reuseTableViewCellIdentifier, forIndexPath: indexPath) as! BrowseTableViewCell2)
        
        let maximumLabelSize: CGSize = CGSize(width: view.bounds.width-5, height: 150)
        let labelRect: CGRect = (matches[indexPath.item].name as NSString).boundingRectWithSize(maximumLabelSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
        
        let leftIndent: CGFloat = 5
        let speciesLabel = UILabel(frame: CGRectMake(leftIndent, cell.frame.origin.y, labelRect.width, labelRect.height))
        speciesLabel.numberOfLines = 0
        speciesLabel.textColor = darkGreen                              //Need to change invasive species to red
        speciesLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        speciesLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        speciesLabel.text = matches[indexPath.item].name
        
        if(matches[indexPath.item].invasive != nil){
            speciesLabel.textColor = UIColor.redColor()
        }
        
        tableView.addSubview(speciesLabel)
        
        
        cell.backgroundColor = UIColor(red: 226.0/255, green: 230.0/255, blue: 226.0/255, alpha: 1.0)
        view.backgroundColor = UIColor(red: 226.0/255, green: 230.0/255, blue: 226.0/255, alpha: 1.0)
        return cell
    }
    
    //Set up cell
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let collectionCell: BrowseTableViewCell2 = cell as! BrowseTableViewCell2
        collectionCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, index: indexPath.row)
        let index: NSInteger = collectionCell.collectionView.tag
        let value: AnyObject? = self.contentOffsetDictionary.valueForKey(index.description)
        let horizontalOffset: CGFloat = CGFloat(value != nil ? value!.floatValue : 0)
        collectionCell.collectionView.setContentOffset(CGPointMake(horizontalOffset, 0), animated: false)
    }
    
    //Determines row height based on # of pictures divided by four per row
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {   let imageLength = (UIScreen.mainScreen().bounds.width-12)/4
        let value = sourceArray[indexPath.item].count
        let fractionNum = Double(value) / 4.0
        let roundedNum = Int(ceil(fractionNum))
        let height = (CGFloat(roundedNum) * imageLength) + 40
        return CGFloat(height)
    }
}
// MARK: - Collection View Data source and Delegate
extension BrowseTableViewController:UICollectionViewDataSource,UICollectionViewDelegate
{
    //Gets number of items based on number of pictures
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let collectionViewArray: NSArray = self.sourceArray[collectionView.tag] as! NSArray
        return collectionViewArray.count
    }
    
    //Get correct collectionview cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell: UICollectionViewCell = (collectionView.dequeueReusableCellWithReuseIdentifier(reuseCollectionViewCellIdentifier, forIndexPath: indexPath) )
      let  subviews = cell.subviews
        if (indexPath.item == 0)
        {
            for subview in subviews
            {
                subview.removeFromSuperview()
            }
        }
        var image = UIImage()
        let imageView = UIImageView()
        imageView.frame = CGRectMake(0,0,91,91)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        //Get correct image
        var imagegot = false
        if (self.photos.count >= collectionView.tag+1)
        {
            if self.photos[collectionView.tag].count >= indexPath.item+1
            {
                image = (self.photos[collectionView.tag])[indexPath.item]
                imagegot = true
            }
        }
        if !imagegot
        {
            let collectionViewArray = self.sourceArray[collectionView.tag] as! NSArray
            var parsedImageName = collectionViewArray[indexPath.item].componentsSeparatedByString(".")
            let newImageName: String = parsedImageName[0] 
            let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + newImageName, ofType: "jpg")
            
            
            if (path != nil)
            {
                image = UIImage(contentsOfFile: path!)!
            }
            
            //Resize image
            let newSize = CGSize(width: 55, height: 55)
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
                imageView.image = newImage
                cell.backgroundView = imageView
            }
            else
            {
                imageView.image = UIImage(named: "fragrant_waterlily5")
                
            }
        }
        else
        {
            imageView.image = image
            cell.backgroundView = imageView
            
        }
        return cell
        
    }

    //Go to slideshow view if photo is selected
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("BrowseSlideshowViewController") as! BrowseSlideshowViewController
        vc.title = title
        vc.speciesIndex = collectionView.tag
        vc.speciesList = matches
        vc.species = matches[collectionView.tag]
        vc.startIndex = indexPath.item
        vc.jsonNavigator = jsonNavigator
        self.navigationController?.pushViewController(vc as UIViewController, animated: true)
        
    }
    
    //Handles scrolling
    override func scrollViewDidScroll(scrollView: UIScrollView)
    {
        if !scrollView.isKindOfClass(UICollectionView)
        {
            return
        }
        let horizontalOffset: CGFloat = scrollView.contentOffset.x
        let collectionView: UICollectionView = scrollView as! UICollectionView
        self.contentOffsetDictionary.setValue(horizontalOffset, forKey: collectionView.tag.description)
    }
}

