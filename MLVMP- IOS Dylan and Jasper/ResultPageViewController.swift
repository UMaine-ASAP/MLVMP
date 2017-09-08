//
//  ResultPageViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by MIke Scott on 8/11/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

//Governs pageviewcontroller showing species pictures

import UIKit

class ResultPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate
{
    var species = Species(name: "Empty", scientificName: "", tags: [], pictures: [], invasive: [], information: [])
    var pageTitles: NSArray!
    var pageImages: NSArray!
    var dotArray = [UIView]()
    var startIndex = 0
    
    //Set up image to be shown at current indexed page
    func viewControllerAtIndex(index: Int) -> ContentViewController
    {
        
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count))
        {
            return ContentViewController()
        }
        let v: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        v.imageFile = self.pageImages[index] as! String
        v.pageIndex = index
        return v
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.pageTitles = species.pictures
        self.pageImages = species.pictures

        self.dataSource = self
        self.delegate = self
        let startVC = self.viewControllerAtIndex(startIndex) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        self.view.frame = CGRect(x: 0,y: 0, width:self.view.frame.width, height: UIScreen.mainScreen().bounds.height - self.navigationController!.navigationBar.frame.height)
        
        
        
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
    }
    
    func Back()
    {   self.navigationController?.popViewControllerAnimated(true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Page View Controller Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        //Increment index to keep track of dots
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        if (index == 0 || index == NSNotFound)
        {
            return nil
            
        }
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {   //Increment image to keep track of dots
        let vc = viewController as! ContentViewController
        var index = vc.pageIndex as Int
        if (index == NSNotFound)
        {
            return nil
        }
        index++
        if (index == self.pageTitles.count)
        {
            return nil
        }
        return self.viewControllerAtIndex(index)
        
    }
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
}
