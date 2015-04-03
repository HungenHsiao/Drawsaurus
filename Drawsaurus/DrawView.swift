//
//  DrawView.swift
//  Drawsaurus
//
//  Created by Shark on 2015-03-31.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DrawViewtoGuessView" {
            let guessVC = segue.destinationViewController as? GuessViewController
            guessVC?.receivedImage = imageToSend
            guessVC?.database = database
        }
    }
    //var imageHolder: UIImage?
    //var stage: StageInfo = StageInfo(roundNumber: 1, description: "", imageSaved: imageHolder!)
    
    
    var database = Database()
    @IBOutlet var descLabel: UILabel!
    
    var red: CGFloat!
    var green: CGFloat!
    var blue: CGFloat!
    var brush: CGFloat = 10.0
    var lastPoint: CGPoint!
    var opacity: CGFloat = 1.0
    var desc: String = ""
    var imageToSend: UIImage?
    var count = 1
    
    var mouseSwiped = false
    
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var tempDrawImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        red = 0.0
        green = 0.0
        blue = 0.0
        descLabel.text = desc
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func colorSelected(sender: UIButton) {
        switch sender.tag {
        case 0:
            red = 0.0
            green = 0.0
            blue = 0.0
        case 1:
            red = 255.0 / 255.0
            green = 0.0
            blue = 0.0
        case 2:
            red = 0.0
            green = 0.0
            blue = 255.0/255.0
        default:
            red = 0.0
            green = 0.0
            blue = 0.0
        }
    }
    
    @IBAction func brushSizeSelected(sender: UIButton) {
        switch sender.tag {
        case 0:
            brush = 3.0
        case 1:
            brush = 10.0
        case 2:
            brush = 30.0
        default:
            brush = 10.0
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        mouseSwiped = false
        lastPoint = touches.anyObject()?.locationInView(self.view)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        mouseSwiped = true
        var currentPoint = touches.anyObject()?.locationInView(self.view)
     //   println("\(currentPoint)")
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        let rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        
        self.tempDrawImage.image?.drawInRect(rect)
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint!.x, currentPoint!.y)
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush)
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0)
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal)
        
        CGContextStrokePath(UIGraphicsGetCurrentContext())
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
        self.tempDrawImage.alpha = opacity
        lastPoint = currentPoint
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        let rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        if !mouseSwiped {
            UIGraphicsBeginImageContext(self.view.frame.size)
            
            self.tempDrawImage.image?.drawInRect(rect)
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity)
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            CGContextFlush(UIGraphicsGetCurrentContext())
            self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        
        
        
        //merge tempDrawImage with mainImage
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.mainImage.image?.drawInRect(rect, blendMode: kCGBlendModeNormal, alpha: 1.0)
        self.tempDrawImage.image?.drawInRect(rect, blendMode: kCGBlendModeNormal, alpha: opacity)
        self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext()
        imageToSend = UIGraphicsGetImageFromCurrentImageContext()
     //   if imageToSend != nil {
            database.addPhase(newPhase: PhaseInfo(roundNumber: count, description: desc, imageSaved: UIGraphicsGetImageFromCurrentImageContext()))
    //    }
        self.tempDrawImage.image = nil
        UIGraphicsEndImageContext()
 /*
        //takes a screenshot of the screen and sends to guessView
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, 0.0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
  */
    
        println("image saved")
    }
}
