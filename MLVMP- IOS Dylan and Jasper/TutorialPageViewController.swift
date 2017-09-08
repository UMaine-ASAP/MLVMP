//
//  TutorialPageViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by MIke Scott on 8/11/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class TutorialPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate
{
    var pageTitles = NSArray(array: [String]())
    var pageImages = NSArray(array: [String]())
    var  dotHolder = UIView()
    var dotArray = [UIView]()
    
    var startIndex = 0
    var fromHelp = false
    func viewControllerAtIndex(index: Int) -> TutorialContentViewController
    {
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count))
        {
            return TutorialContentViewController()
        }
        
        let v: TutorialContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TutorialContentViewController") as! TutorialContentViewController
        v.imageFile = self.pageImages[index] as! String
        v.pageIndex = index
        v.dotArray = dotArray
        
        return v
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.95)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.pageTitles = ["0", "1", "2", "3", "4"]
        self.pageImages = ["0", "1", "2", "3", "4"]
        let width = (4)*20 + 14
        let y = UIScreen.mainScreen().bounds.height-90
        dotHolder.frame = CGRectMake(CGFloat(0), y,  CGFloat(width),  CGFloat(30))
        dotHolder.frame.origin.x = (self.view.frame.width/2) - dotHolder.frame.width/2
        var xc = 0
        for x in 0...4
        {
            let dot = UIView()
            if (x == startIndex)
            {dot.backgroundColor = UIColor(red: 226/255, green: 230/255, blue: 226/255, alpha: 1.0)}
            else
            {dot.backgroundColor = UIColor(red: 97/255, green: 97/255, blue: 97/255, alpha: 1.0)}
            dot.frame = CGRect(x: xc, y: 2, width: 14, height: 14)
            dot.layer.cornerRadius = dot.frame.size.width/2
            dot.clipsToBounds = true
            xc += 20
            dotHolder.addSubview(dot)
            dotArray.append(dot)
            
        }
        
        self.view.addSubview(dotHolder)
        
        
        self.dataSource = self
        self.delegate = self
        let startVC = self.viewControllerAtIndex(startIndex) as TutorialContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        if (fromHelp)
        {
            self.view.frame = CGRect(x: 0,y: 0, width:self.view.frame.width, height:self.view.frame.size.height)
        }
            
        else
        {
            self.view.frame = CGRect(x: 0,y: 0, width:self.view.frame.width, height:self.view.frame.size.height)
        }
        
        let homeButton = UIBarButtonItem(title: "Back", style: .Plain , target: self, action: "Back")
        self.navigationItem.setLeftBarButtonItem(homeButton, animated: false)
        // Do any additional setup after loading the view.
        
        
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
        let vc = viewController as! TutorialContentViewController
        var index = vc.pageIndex as Int
        if (index == 0 || index == NSNotFound)
        {
            return nil
            
        }
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        let vc = viewController as! TutorialContentViewController
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
