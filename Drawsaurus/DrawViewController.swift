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
            if mainImage.image == nil {
                database.append(DrawingPhase(drawing: UIImage(named: "placeholder")!))
            } else {
                database.append(DrawingPhase(drawing: mainImage.image!))
    
            }
            guessVC?.receivedImage = mainImage.image
            guessVC?.database = database
            guessVC?.receivedDesc = desc
        }
    }
    
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var mainImage: UIImageView!
    
    var database: [Phase]!

    var red: CGFloat!
    var green: CGFloat!
    var blue: CGFloat!
    var brush: CGFloat = 5.0
    var lastPoint: CGPoint!
    var opacity: CGFloat = 1.0
    var desc: String = ""
    
    var mouseSwiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        red = 0.0
        green = 0.0
        blue = 0.0
        descLabel.text = desc
    }
    
    @IBAction func colorSelected(sender: UIButton) {
        switch sender.tag {
        case 0:
            red = 0/255.0
            green = 0/255.0
            blue = 0/255.0
        case 1:
            red = 255/255.0
            green = 0/255.0
            blue = 0/255.0
        case 2:
            red = 0/255.0
            green = 0/255.0
            blue = 255/255.0
        case 3:
            red = 0/255.0
            green = 255/255.0
            blue = 0/255.0

        default:
            red = 0/255.0
            green = 0/255.0
            blue = 0/255.0
        }
    }
    
    @IBAction func brushSizeSelected(sender: UIButton) {
        switch sender.tag {
        case 0:
            brush = 1.0
        case 1:
            brush = 5.0
        case 2:
            brush = 13.0
        default:
            brush = 5.0
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        mouseSwiped = false
        if let currentTouch = touches.first as? UITouch {
            lastPoint = currentTouch.locationInView(self.mainImage)
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        mouseSwiped = true
        
        if let currentTouch = touches.first as? UITouch {
            
            var currentPoint = currentTouch.locationInView(self.mainImage)
            
            UIGraphicsBeginImageContext(self.mainImage.frame.size)
            
            self.mainImage.image?.drawInRect(CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height))
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y)
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0)
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal)
            
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext()
            self.mainImage.alpha = opacity
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let rect = CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height)
        if !mouseSwiped {
            UIGraphicsBeginImageContext(self.mainImage.frame.size)
            
            self.mainImage.image?.drawInRect(rect)
            CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound)
            CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush)
            CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity)
            CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y)
            CGContextStrokePath(UIGraphicsGetCurrentContext())
            CGContextFlush(UIGraphicsGetCurrentContext())
            self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }
}


