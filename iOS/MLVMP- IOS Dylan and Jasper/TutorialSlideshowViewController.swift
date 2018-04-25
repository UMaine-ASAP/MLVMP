//
//  SlideshowViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by MIke Scott on 7/28/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class TutorialSlideshowViewController: UIViewController, UIPageViewControllerDataSource {
    var species = Species(name: "Empty", scientificName: "", tags: [], pictures: [], otherNames: [], family: [], identifyingCharacteristics: [], biology: [], diet: [], habitat: [], lookAlikes: [], commonlySeen: [], range: [], details: [], invasive: [])
    var tutorialPageViewController = UIPageViewController()

    var pageTitles: [String] = ["1","2","3","4","5"]
    
    func viewControllerAtIndex(index: Int) -> TutorialContentViewController
    {
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count))
        {
            return TutorialContentViewController()
        }
        
        var v: TutorialContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TutorialContentViewController") as! TutorialContentViewController
        //v.imageFile = self.pageImages[index] as! String
        v.pageIndex = index
        return v
    }
    override func viewDidLoad() {
        super.viewDidLoad()


        
        self.tutorialPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TutorialPageViewController") as! UIPageViewController
        self.tutorialPageViewController.dataSource = self
        var startVC = self.viewControllerAtIndex(0) as TutorialContentViewController
        var viewControllers = NSArray(object: startVC)
        
        self.tutorialPageViewController.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: true, completion: nil)
        //self.tutorialPageViewController.view.frame = CGRect(x: 0,y: 30, width:self.view.frame.width, height:self.view.frame.size.height - 60)
        
        self.tutorialPageViewController.view.frame = CGRect(x: 0,y: 0, width:self.view.frame.width, height:self.view.frame.size.height)
        
        self.addChildViewController(self.tutorialPageViewController)
        self.view.addSubview(self.tutorialPageViewController.view)
        self.tutorialPageViewController.didMoveToParentViewController(self)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Page View Controller Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! TutorialContentViewController
        var index = vc.pageIndex as Int
        if (index == 0 || index == NSNotFound)
        {
            return nil
            
        }
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var vc = viewController as! TutorialContentViewController
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
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
}
}
