//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var eggTime: [String:Float] = ["Soft": 2, "Medium": 7, "Hard": 12]
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var eggProgressBar: UIProgressView!
    var timer = Timer()
    
    @IBAction func eggButton(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
                
        var runCount = eggTime[hardness]!
        
        self.mainLabel.text = hardness + " is selected."

        eggProgressBar.progress = runCount / eggTime[hardness]!
        
        print("Timer Fired for ", runCount, "sec.")
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {timer in
            
            runCount -= 1
            self.eggProgressBar.progress = runCount / self.eggTime[hardness]!
            
            if runCount <= 0 {
                timer.invalidate()
                print("Done")
                self.playSound()
                self.mainLabel.text = "DONE"
            } else {
                self.mainLabel.text = String(runCount) + " sec left."
            }
        }
//        print(eggTime.values[eggTime.index(forKey: hardness)!])
//        switch hardness {
//        case "Soft":
//            print(eggTime)
//        case "Medium":
//            print("Medium")
//        case "Hard" :
//            print("Hard as a Rock")
//        default :
//            print("I don't get it")
//        }
    }
    func playSound() {
        let url = Bundle.main.url(forResource:"alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
    }
}
