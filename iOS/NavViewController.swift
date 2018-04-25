//
//  NavViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by MIke Scott on 8/18/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return self.visibleViewController!.preferredInterfaceOrientationForPresentation()
    }
    override func shouldAutorotate() -> Bool {
        return self.visibleViewController!.shouldAutorotate()
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
