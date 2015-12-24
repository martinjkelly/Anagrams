//
//  Ga.swift
//  Anagrams
//
//  Created by Martin Kelly on 24/12/2015.
//  Copyright © 2015 Caroline. All rights reserved.
//

import Foundation

class GameData {
    
    var points:Int = 0 {
        didSet {
            points = max(points, 0)
        }
    }
}