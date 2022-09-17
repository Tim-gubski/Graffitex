//
//  Coordinator.swift
//  GraffitexApp
//
//  Created by Nihal Syed on 2022-09-17.
//

import Foundation
import RealityKit
import SwiftUI
import UIKit
import ARKit
import Combine

class Coordinator: NSObject {
    
    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        guard let view = self.view else { return }
        //load canvas model
        //let canvasAnchor = try! Canvas.load_Canvas()
        
        let tapLocation = recognizer.location(in: view)
        let results = view.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any)
        
        if let result = results.first {
            
            let anchorEntity = AnchorEntity(raycastResult: result)
            let modelEntity = ModelEntity(mesh: MeshResource.generateBox(width: 0.7, height: 0.01, depth: 0.6))
            modelEntity.generateCollisionShapes(recursive: true)
            modelEntity.model?.materials = [SimpleMaterial(color: .white, isMetallic: false)]
            anchorEntity.addChild(modelEntity)
            view.scene.addAnchor(anchorEntity)
            view.installGestures(.all ,for: modelEntity)
        }
    }
}
