//
//  Timer.swift
//  Drawsaurus
//
//  Created by Shark on 2015-05-24.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit

class Timer {
    var timer = NSTimer()
    var timeRemaining = 59
    
    func countDown(label: UILabel) {
        timeRemaining--
        label.text = "\(timeRemaining)"
    }
    
    func startTimer() {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("countDown"), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        if timeRemaining == 0 {
            timer.invalidate()
        }
    }
}