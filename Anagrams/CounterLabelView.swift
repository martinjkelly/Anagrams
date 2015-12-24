//
//  CounterLabelView.swift
//  Anagrams
//
//  Created by Martin Kelly on 24/12/2015.
//  Copyright © 2015 Caroline. All rights reserved.
//

import UIKit

class CounterLabelView: UILabel {
    
    private var endValue: Int = 0
    private var timer: NSTimer? = nil
    
    var value:Int = 0 {
        didSet {
            self.text = "\(value)"
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("use init(font:,frame:)")
    }
    
    init(font:UIFont, frame: CGRect) {
        super.init(frame: frame)
        self.font = font
        self.textAlignment = NSTextAlignment.Center
        self.backgroundColor = UIColor.clearColor()
    }
    
    func updateValue(timer:NSTimer) {
        //1 update the value
        if (endValue < value) {
            value -= 1
        } else {
            value += 1
        }
        
        //2 stop and clear the timer
        if (endValue == value) {
            timer.invalidate()
            self.timer = nil
        }
    }
    //count to a given value
    func setValue(newValue:Int, duration:Float) {
        //1 set the end value
        endValue = newValue
        
        //2 cancel previous timer
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
        //3 calculate the interval to fire each timer
        let deltaValue = abs(endValue - value)
        if (deltaValue != 0) {
            var interval = Double(duration / Float(deltaValue))
            if interval < 0.01 {
                interval = 0.01
            }
            
            //4 set the timer to update the value
            timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector:"updateValue:", userInfo: nil, repeats: true)
        }
    }
}
