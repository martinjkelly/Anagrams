//
//  Level.swift
//  Anagrams
//
//  Created by Martin Kelly on 23/12/2015.
//  Copyright © 2015 Caroline. All rights reserved.
//

import Foundation

struct Level
{
    let pointsPerTile: Int
    let timeToSolve: Int
    let anagrams: [NSArray]
    
    init(levelNumber: Int) {
        let fileName = "level\(levelNumber).plist"
        let levelPath = "\(NSBundle.mainBundle().resourcePath!)/\(fileName)"
        
        let levelDictionary:NSDictionary? = NSDictionary(contentsOfFile: levelPath)
        
        assert(levelDictionary != nil, "Level configuratoin file not found")
        
        pointsPerTile = levelDictionary!["pointsPerTile"] as! Int
        timeToSolve = levelDictionary!["timeToSolve"] as! Int
        anagrams = levelDictionary!["anagrams"] as! [NSArray]
    }
}