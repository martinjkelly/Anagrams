//
//  GameController.swift
//  Anagrams
//
//  Created by Martin Kelly on 23/12/2015.
//  Copyright © 2015 Caroline. All rights reserved.
//

import UIKit

class GameController
{
    var gameView: UIView!
    var level: Level!
    private var tiles = [TileView]()
    private var targets = [TargetView]()
    
    init() {
        
    }
    
    func dealRandomAnagram() {
        
        assert(level.anagrams.count > 0, "no level loaded")
        
        let randomIndex = randomNumber(minX: 0, maxX: UInt32(level.anagrams.count - 1))
        let anagramPair = level.anagrams[randomIndex]
        
        let anagram1 = anagramPair[0] as! String
        let anagram2 = anagramPair[1] as! String
        
        let anagram1length = anagram1.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        let anagram2length = anagram2.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        
        print("anagram1 length is \(anagram1length)")
        print("anagram2 length is \(anagram2length)")
        
        let tileSide = ceil(ScreenWidth * 0.9 / CGFloat(max(anagram1length, anagram2length))) - TileMargin
        
        var offsetX = (ScreenWidth - CGFloat(max(anagram1length, anagram2length)) * (tileSide + TileMargin)) / 2.0
        offsetX += tileSide / 2.0
        
        targets = []
        
        for (index, letter) in anagram2.characters.enumerate() {
            if (letter != " ") {
                let target = TargetView(letter: letter, sideLength: tileSide)
                target.center = CGPointMake(offsetX + CGFloat(index) * (tileSide + TileMargin), ScreenHeight / 4)
                
                gameView.addSubview(target)
                targets.append(target)
            }
        }
        
        tiles = []
        
        for (idx, letter) in anagram1.characters.enumerate() {
            if letter != " " {
                let tile = TileView(letter: letter, sideLength: tileSide)
                tile.center = CGPointMake(offsetX + CGFloat(idx)*(tileSide + TileMargin), ScreenHeight/4*3)
                tile.randomize()
                tile.dragDelegate = self
                
                gameView.addSubview(tile)
                tiles.append(tile)
            }
        }
        
    }
    
    func placeTile(tileView: TileView, targetView: TargetView) {
        
        targetView.isMatched = true
        tileView.isMatched = true
        
        tileView.userInteractionEnabled = false
        
        UIView.animateWithDuration(0.35,
            delay: 0.00,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: {
                tileView.center = targetView.center
                tileView.transform = CGAffineTransformIdentity
            }, completion: { (value:Bool) in
                targetView.hidden = true
        })
    }
    
    func checkForSuccess() {
        for targetView in targets {
            if (!targetView.isMatched) {
                return
            }
        }
        print("Game over")
    }
}

extension GameController:TileDragDelegateProtocol {
    
    func tileView(tileView: TileView, didDragToPoint point: CGPoint) {
        var targetView: TargetView?
        for tv in targets {
            if tv.frame.contains(point) && !tv.isMatched {
                targetView = tv
                break
            }
        }
        
        if let targetView = targetView {
            if targetView.letter == tileView.letter {
                
                self.placeTile(tileView, targetView: targetView)
                self.checkForSuccess()
                
            } else {
                
                tileView.randomize()
                
                UIView.animateWithDuration(0.35,
                    delay: 0.00,
                    options: UIViewAnimationOptions.CurveEaseOut,
                    animations: {
                        tileView.center = CGPointMake(tileView.center.x + CGFloat(randomNumber(minX: 0, maxX: 40)-20), tileView.center.y + CGFloat(randomNumber(minX: 20, maxX: 30)))
                    }, completion: nil)
            }
        }
    }
}
