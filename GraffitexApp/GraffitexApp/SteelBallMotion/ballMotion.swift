//
//  ballMotion.swift
//  GraffitexApp
//
//  Created by User on 2022-09-17.
//

import SwiftUI
import CoreMotion


class ViewController: UIViewController {

    let motionManager = CMMotionManager()
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        motionManager.startMagnetometerUpdates()
        motionManager.startDeviceMotionUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }

    @objc func update() {
        if let accelerometerData = motionManager.accelerometerData {
            print(accelerometerData)
        }
    }
    
}
