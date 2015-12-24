//
//  ExplodeView.swift
//  Anagrams
//
//  Created by Martin Kelly on 24/12/2015.
//  Copyright © 2015 Caroline. All rights reserved.
//

import UIKit

class ExplodeView: UIView {
    
    private var emitter: CAEmitterLayer!
    
    override class func layerClass() -> AnyClass {
        return CAEmitterLayer.self
    }
    
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(frame:")
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        //initialize the emitter
        emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        emitter.emitterSize = self.bounds.size
        emitter.emitterMode = kCAEmitterLayerAdditive
        emitter.emitterShape = kCAEmitterLayerRectangle
    }
    
    override func didMoveToSuperview() {
        //1
        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        
        //2
        let texture:UIImage? = UIImage(named:"particle")
        assert(texture != nil, "particle image not found")
        
        //3
        let emitterCell = CAEmitterCell()
        
        //4
        emitterCell.contents = texture!.CGImage
        
        //5
        emitterCell.name = "cell"
        
        //6
        emitterCell.birthRate = 1000
        emitterCell.lifetime = 0.75
        
        //7
        emitterCell.blueRange = 0.33
        emitterCell.blueSpeed = -0.33
        
        //8
        emitterCell.velocity = 160
        emitterCell.velocityRange = 40
        
        //9
        emitterCell.scaleRange = 0.5
        emitterCell.scaleSpeed = -0.2
        
        //10
        emitterCell.emissionRange = CGFloat(M_PI*2)
        
        //11
        emitter.emitterCells = [emitterCell]
        
        // disable the emitter
        var delay = Int64(0.1 * Double(NSEC_PER_SEC))
        var delayTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.disableEmitterCell()
        }
        
        delay = Int64(2 * Double(NSEC_PER_SEC))
        delayTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.removeFromSuperview()
        }
    }
    
    func disableEmitterCell() {
        emitter.setValue(0, forKey: "emitterCells.cell.birthRate")
    }
}
