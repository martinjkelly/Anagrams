//
//  ViewController.swift
//  Anagrams
//
//  Created by Caroline on 1/08/2014.
//  Copyright (c) 2014 Caroline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let controller:GameController
    
    required init?(coder aDecoder: NSCoder) {
        controller = GameController()
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        let level1 = Level(levelNumber: 3)
        print("anagrams: \(level1.anagrams)")
        
        let gameView = UIView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
        view.addSubview(gameView)
        controller.gameView = gameView
        
        //add one view for all hud and controls
        let hudView = HUDView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(hudView)
        controller.hud = hudView
        
        controller.level = level1
        controller.dealRandomAnagram()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

