//
//  ViewController.swift
//  eggTimer
//
//  Created by Kuba  on 21/04/2020.
//  Copyright © 2020 Kuba . All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var eggImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning = false
    let egg = ["18", "30", "54"]
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func degreeOfCooking(_ sender: UISegmentedControl) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            timeLabel.text = egg[0]
            eggImage.image = UIImage(named: "soft_egg")
            timer.invalidate()
        case 1:
            timeLabel.text = egg[1]
            eggImage.image = UIImage(named: "medium_egg")
            timer.invalidate()
        case 2:
            timeLabel.text = egg[2]
            eggImage.image = UIImage(named: "hard_egg")
            timer.invalidate()
        default:
            break
        }
        seconds = Int(timeLabel.text!) ?? 0
    }
    @IBAction func countingDownPressed(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer () {
        
        let min = seconds / 60 % 60
        let sec = seconds % 60
        
        if seconds > 0 {
            timeLabel.text = String(format: "%02i:%02i", min, sec)
            seconds -= 1
        } else {
            timer.invalidate()
            playSound()
            timeLabel.text! = "Gotowe!"
        }
    }
    func playSound() {
        let url = Bundle.main.url(forResource: "Alarm_Clock", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

