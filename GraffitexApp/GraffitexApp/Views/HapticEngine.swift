//
//  HapticEngine.swift
//  GraffitexApp
//
//  Created by Tim Gubski on 9/17/22.
//

import Foundation
import CoreHaptics

class HapticEngine{
    
    var engine: CHHapticEngine?
    // ...
    do
    {
        engine = try CHHapticEngine()
        try engine?.start()
    } catch {
        print("Problem with haptics: \(error)")
    }
    
}
