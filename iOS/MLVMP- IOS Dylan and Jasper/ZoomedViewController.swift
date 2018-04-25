//
//  ZoomedViewController.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Dylan Landry on 7/25/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import UIKit

class ZoomedViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    var image = UIImage()
    var imageView = UIImageView()
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        
        
        scrollView.frame = CGRectMake(0, navigationController!.navigationBar.frame.height - 20, UIScreen.mainScreen().bounds.width, (view.bounds.height - (navigationController!.navigationBar.frame.height - 20)) - 30)
        

        
        
            let image = self.image
            imageView = UIImageView(image: image)
            
            var ratio: CGFloat = image.size.width/image.size.height
            var screenHeight: CGFloat = UIScreen.mainScreen().bounds.height - navigationController!.navigationBar.frame.height - 20
            var screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
        
        
        imageView.frame = CGRectMake(0, ((scrollView.frame.height - image.size.height)/2), image.size.width, image.size.height)
        
            
//            if(ratio > 1){
//                
//                imageView.frame = CGRectMake(0, 0, ((screenWidth)/13) * 12, 0)
//                imageView.frame = CGRectMake(0, 0, imageView.frame.width, imageView.frame.width / ratio)
//                
//                
//            } else {
//                
//                imageView.frame =  CGRectMake(0, 0, 0, (screenHeight/13)*12)
//                imageView.frame = CGRectMake(0, 0, imageView.frame.height * ratio, imageView.frame.height)
        
//                if(imageView.frame.width > screenWidth){
//                    
//                    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, screenWidth - 20, imageView.frame.height)
//                    imageView.frame = CGRectMake((screenWidth - (imageView.frame.width))/2, imageView.frame.origin.y, imageView.frame.width, imageView.frame.width/ratio)
//                    
//                }
                
                
                
//            }
        
//            //println(ratio)
        
//            imageView.frame.origin = CGPoint(x: (scrollView.frame.width - imageView.frame.width)/2, y: (((scrollView.frame.height/13)*12) - imageView.frame.height)/2)
//            
//            imageView.frame.origin = CGPoint(x: imageView.frame.origin.x, y: imageView.frame.origin.y)
        
        //imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.width*2, imageView.frame.height*2)
        
        //imageView.center.x = scrollView.frame.width/2
        //imageView.center.y = scrollView.frame.height/2
            
             //[imageScrollView setContentMode:UIViewContentModeScaleAspectFit];
        
            //scrollView.contentMode = UIViewContentMode.ScaleAspectFit
            
            imageView.userInteractionEnabled = true
            //imageView.contentMode = UIViewContentMode.ScaleAspectFit
            
            scrollView.addSubview(imageView)
            
            scrollView.backgroundColor = UIColor.blackColor()
            
            
            scrollView.contentSize = imageView.frame.size
        
        
        //scrollView.frame = CGRectMake(scrollView.frame.origin.x - 100, scrollView.frame.origin.y, scrollView.frame.width, scrollView.frame.height)
        scrollView.bounds = CGRectMake(scrollView.bounds.origin.x + ((imageView.frame.width - scrollView.frame.width)/2), scrollView.bounds.origin.x, scrollView.bounds.width, scrollView.bounds.width)
        
        
        
            
        
            
        }
        
        
        
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //println(imageView.frame.origin.x)
        //println(scrollView.frame.origin.x)
        //println(scrollView.bounds.origin.x)
    }
        
        
//    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
//        return imageView
//    }
    
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
