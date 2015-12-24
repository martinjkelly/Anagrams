//
//  TileView.swift
//  Anagrams
//
//  Created by Martin Kelly on 23/12/2015.
//  Copyright © 2015 Caroline. All rights reserved.
//

import UIKit

protocol TileDragDelegateProtocol {
    func tileView(tileView: TileView, didDragToPoint: CGPoint)
}

class TileView: UIImageView {
    
    var letter:Character
    var isMatched: Bool = false
    var dragDelegate: TileDragDelegateProtocol?
    
    private var xOffset: CGFloat = 0.0
    private var yOffset: CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init(letter:, sideLength:")
    }
    
    init(letter: Character, sideLength: CGFloat) {
        self.letter = letter
        
        let image = UIImage(named: "tile")!
        
        super.init(image:image)
        
        let scale = sideLength / image.size.width
        self.frame = CGRect(x: 0, y: 0, width: image.size.width * scale, height: image.size.height * scale)
        
        let letterLabel = UILabel(frame: self.bounds)
        letterLabel.textAlignment = NSTextAlignment.Center
        letterLabel.textColor = UIColor.whiteColor()
        letterLabel.backgroundColor = UIColor.clearColor()
        letterLabel.text = String(letter).uppercaseString
        letterLabel.font = UIFont(name: "Verdana-Bold", size: 78.0 * scale)
        self.addSubview(letterLabel)
        
        self.userInteractionEnabled = true
    }
    
    func randomize() {
        
        let rotation = CGFloat(randomNumber(minX:0, maxX:50)) / 100.0 - 0.2
        self.transform = CGAffineTransformMakeRotation(rotation)
        
        let yOffset = CGFloat(randomNumber(minX: 0, maxX: 10) - 10)
        self.center = CGPointMake(self.center.x, self.center.y + yOffset)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.locationInView(self.superview)
            xOffset = point.x - self.center.x
            yOffset = point.y - self.center.y
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.locationInView(self.superview)
            self.center = CGPointMake(point.x - xOffset, point.y - yOffset)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.touchesMoved(touches, withEvent: event)
        dragDelegate?.tileView(self, didDragToPoint: self.center)
    }
}
