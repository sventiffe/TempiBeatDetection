//
//  BPMViewController.swift
//  TempiBeatDetection
//
//  Created by John Scalo on 4/26/16.
//  Copyright © 2016 John Scalo. See accompanying License.txt for terms.

import UIKit

class BPMViewController: UIViewController {

    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var range60Button: UIButton!
    @IBOutlet weak var range80Button: UIButton!
    @IBOutlet weak var range100Button: UIButton!
    @IBOutlet weak var range120Button: UIButton!
    
    private let beatDetector: TempiBeatDetector = TempiBeatDetector()

    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.isIdleTimerDisabled = true
        
        beatDetector.beatDetectionHandler = {(timeStamp: Double, bpm: Float) in self.beatDetected(timeStamp: timeStamp, bpm: bpm)}
        beatDetector.minTempo = 80
        beatDetector.maxTempo = 160
        
        self.updateButtons()
        
        beatDetector.startFromMic()
    }

    @IBAction func range60Button(sender: UIButton) {
        self.reset(minTempo: 60, maxTempo: 120)
    }
    
    @IBAction func range80Button(sender: UIButton) {
        self.reset(minTempo: 80, maxTempo: 160)
    }

    @IBAction func range100Button(sender: UIButton) {
        self.reset(minTempo: 100, maxTempo: 200)
    }

    @IBAction func range120Button(sender: UIButton) {
        self.reset(minTempo: 120, maxTempo: 240)
    }

    private func reset(minTempo minTempo: Float, maxTempo: Float) {
        self.beatDetector.minTempo = minTempo
        self.beatDetector.maxTempo = maxTempo
        self.updateButtons()
        self.restartDetector()
    }
    
    private func updateButtons() {
        self.range60Button.backgroundColor = UIColor.clear
        self.range60Button.layer.cornerRadius = self.range60Button.frame.size.height / 2.0
        self.range60Button.setTitleColor(UIColor.white, for: UIControl.State.normal)

        self.range80Button.backgroundColor = UIColor.clear
        self.range80Button.layer.cornerRadius = self.range60Button.frame.size.height / 2.0
        self.range80Button.setTitleColor(UIColor.white, for: UIControl.State.normal)

        self.range100Button.backgroundColor = UIColor.clear
        self.range100Button.layer.cornerRadius = self.range60Button.frame.size.height / 2.0
        self.range100Button.setTitleColor(UIColor.white, for: UIControl.State.normal)

        self.range120Button.backgroundColor = UIColor.clear
        self.range120Button.layer.cornerRadius = self.range60Button.frame.size.height / 2.0
        self.range120Button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        if self.beatDetector.minTempo == 60.0 {
            self.range60Button.backgroundColor = UIColor.orange
        } else if self.beatDetector.minTempo == 80.0 {
            self.range80Button.backgroundColor = UIColor.orange
        } else if self.beatDetector.minTempo == 100.0 {
            self.range100Button.backgroundColor = UIColor.orange
        } else if self.beatDetector.minTempo == 120.0 {
            self.range120Button.backgroundColor = UIColor.orange
        }
    }

    private func restartDetector() {
        self.bpmLabel.text = "——"
        self.beatDetector.stop()
        self.beatDetector.startFromMic()
    }
    
    private func beatDetected(timeStamp: Double, bpm: Float) {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.bpmLabel.text = String(format: "%0.0f", bpm)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("*** Low memory ***");
    }
}

