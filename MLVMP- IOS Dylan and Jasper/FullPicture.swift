//
//  FullPicture.swift
//  MLVMP- IOS Dylan and Jasper
//
//  Created by Administrator on 6/24/15.
//  Copyright (c) 2015 Dylan Landry. All rights reserved.
//

import Foundation
import UIKit

class FullPicture: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate{


    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var species = Species(name: "Empty", scientificName: "", tags: [], pictures: [], otherNames: [], family: [], identifyingCharacteristics: [], biology: [], diet: [], habitat: [], lookAlikes: [], commonlySeen: [], range: [], details: [], invasive: [], footnote: [])
    var imageView = UIImageView()
    var images = [UIImage()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pictures (\(species.pictures!.count))"
        scrollView.frame = CGRectMake(0, navigationController!.navigationBar.frame.height - 20, UIScreen.mainScreen().bounds.width, (view.bounds.height - (navigationController!.navigationBar.frame.height - 20)) - 30)
        
        scrollView.delegate = self
        
        for (var index: Int = 0; index < species.pictures!.count; index++){
            var imageName = String()
            imageName = species.pictures![index]
            var parsedImageName = imageName.componentsSeparatedByString(".") as [String]
            let newImageName: String = parsedImageName[0] as String
            let path = NSBundle.mainBundle().pathForResource("MVLMP Images (Resized)/" + newImageName, ofType: "jpg")
            var image = UIImage()
            image = UIImage(contentsOfFile: path!)!
            images.append(image)
            imageView = UIImageView(image: image)
        
            let ratio: CGFloat = image.size.width/image.size.height
            let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height - navigationController!.navigationBar.frame.height - 20
            let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
        
            if(ratio > 1){
            
                imageView.frame = CGRectMake(0, 0, ((screenWidth)/13) * 12, 0)
                imageView.frame = CGRectMake(0, 0, imageView.frame.width, imageView.frame.width / ratio)
               
        
            } else {

                imageView.frame =  CGRectMake(0, 0, 0, (screenHeight/13)*12)
                imageView.frame = CGRectMake(0, 0, imageView.frame.height * ratio, imageView.frame.height)
                
                if(imageView.frame.width > screenWidth){
                    
                    imageView.frame = CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y, screenWidth - 20, imageView.frame.height)
                    imageView.frame = CGRectMake((screenWidth - (imageView.frame.width))/2, imageView.frame.origin.y, imageView.frame.width, imageView.frame.width/ratio)
                    
                }
            
            
        
            }
            
            //println(ratio)
        
            imageView.frame.origin = CGPoint(x: (scrollView.frame.width - imageView.frame.width)/2, y: (((scrollView.frame.height/13)*12) - imageView.frame.height)/2)
            
            imageView.frame.origin = CGPoint(x: CGFloat(imageView.frame.origin.x + (screenWidth * CGFloat(index))), y: imageView.frame.origin.y)
            //imageView.frame.origin = CGPoint(x: (screenWidth*CGFloat(index)), y: imageView.frame.origin.y)
            let button = UIButton(frame: imageView.frame)
            button.addTarget(self, action: "pressed:", forControlEvents: UIControlEvents.TouchUpInside)
            button.setTitle(newImageName, forState: .Normal)
            
            let attributedString = NSMutableAttributedString(string: String(index))
            attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red:0.89, green:0.90, blue:0.89, alpha:0), range: NSRange(location: 0, length: attributedString.length))
            
            button.setTitle(String(index), forState: .Normal)
            
            button.setAttributedTitle(attributedString , forState: UIControlState.Normal)
            
        
        imageView.userInteractionEnabled = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        scrollView.addSubview(imageView)
            scrollView.addSubview(button)
        //scrollView.backgroundColor = UIColor.redColor()


        scrollView.contentSize.width += screenWidth
        
        scrollView.contentSize.height = imageView.frame.height
            
            //println("Picture \(index + 1) starts at \(imageView.frame.origin.x) and ends at \(imageView.frame.origin.x + imageView.frame.width)")
            
            //scrollView.contentMode = UIViewContentMode.ScaleAspectFit
            
            if(index == species.pictures!.count - 1){
                images.removeAtIndex(0)
            }
            
        
        }
    
        
        
        
        //println(UIScreen.mainScreen().bounds.width)
    
    }
    
    func pressed(sender: UIButton){
        
        let vc : ZoomedViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ZoomedViewController") as! ZoomedViewController
        
        var number: Int? = Int((sender.titleLabel!.text)!)
        //println(number)
                vc.image = images[number!]
        //println("sending \(images.description)")
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
    
    
}
