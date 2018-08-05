//
//  ViewController.swift
//  LightSaberApp
//
//  Created by Yamada Takahiro on 2018/08/05.
//  Copyright © 2018年 takahiro. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {
    
    let motionManager: CMMotionManager = CMMotionManager()
    
    // iPhoneを振った音を出すための再生オブジェクトを格納します。
    var audioPlayer: AVAudioPlayer = AVAudioPlayer()
    
    // ボタンを押した時の音を出すための再生オブジェクトを格納します。
    var startAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    var startAccel: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        setupSound()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func tappedStartButton(_ sender: UIButton) {
        startAudioPlayer.play()
        startGetAccelerometer()
    }
    func setupSound() {
        // ボタンを押した時の音
        if let sound = Bundle.main.path(forResource: "light_saber1", ofType: ".mp3") {
            startAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            startAudioPlayer.prepareToPlay()
        }
        
        // iPhoneを振った時の音
        if let sound = Bundle.main.path(forResource: "light_saber3", ofType: ".mp3") {
            audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            audioPlayer.prepareToPlay()
        }
        
    }
    func startGetAccelerometer() {
        motionManager.accelerometerUpdateInterval = 1/100
        
        // 検出開始と検出後の処理
        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (accelerometerData: CMAccelerometerData?, error: Error?) in
            if let acc = accelerometerData {
                let x = acc.acceleration.x
                let y = acc.acceleration.y
                let z = acc.acceleration.z
                let synthetic = (x * x) + (y * y) + (z * z)
                if self.startAccel == false && synthetic >= 4 {
                    self.startAccel = true
                    self.audioPlayer.currentTime = 0
                    self.audioPlayer.play()
                    if self.startAccel == true && synthetic < 1 {
                        self.startAccel = false

                
                
                
//                if synthetic >= 8 {
//                    self.audioPlayer.currentTime = 0
//                    self.audioPlayer.play()
            }
        
        }
}

}
}
}
