//
//  AudioController.swift
//  Anagrams
//
//  Created by Martin Kelly on 24/12/2015.
//  Copyright © 2015 Caroline. All rights reserved.
//

import AVFoundation

class AudioController {
    
    private var audio = [String:AVAudioPlayer]()
    
    func preloadAudioEffects(effectsFilename:[String]) {
        
        for effect in AudioEffectFiles {
            
            // 1 get the effect file path URL
            let soundPath = (NSBundle.mainBundle().resourcePath! as NSString).stringByAppendingPathComponent(effect)
            let soundURL = NSURL.fileURLWithPath(soundPath)
            
            // 2 load the file contents
            let player = try? AVAudioPlayer(contentsOfURL: soundURL)
            assert(player != nil, "Load sound failed")
            
            // 3 prepare to play
            player?.numberOfLoops = 0
            player?.prepareToPlay()
            
            audio[effect] = player
        }
    }
    
    func playEffect(name:String) {
        
        if let player = audio[name] {
            if player.playing {
                player.currentTime = 0
            } else {
                player.play()
            }
        }
    }
}
