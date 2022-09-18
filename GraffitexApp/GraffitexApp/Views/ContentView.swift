//
//  ContentView.swift
//  GraffitexApp
//
//  Created by Tim Gubski on 9/17/22.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        return ZStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
//                DrawingScreen()
                ButtonBarUpper()
                ButtonBarLower()
                
            }
        }
        .edgesIgnoringSafeArea(.all)
//
    }
}

struct ARViewContainer: UIViewRepresentable {
    @State public var arView : ARView?
    
    func makeUIView(context: Context) -> ARView {

        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
        
        arView.enableTapGesture()
        
        return arView
    }
    
//    public func cast(){
//        guard let tapLocation = arView?.center else { return }
//
//        let results = arView?.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any)
//
//        if let firstResult = results?.first {
//            let position = simd_make_float3(firstResult.worldTransform.columns.3)
//            placeCube(at:position)
//        }
//    }
//
//    func placeCube(at position: SIMD3<Float>){
//        let mesh = MeshResource.generateSphere(radius: 0.01)
//        let material = SimpleMaterial(color: .red, roughness: 0.3, isMetallic: true)
//        let modelEntity = ModelEntity(mesh: mesh,materials: [material])
//
//        modelEntity.generateCollisionShapes(recursive: true)
//
//        let anchorEntity = AnchorEntity(world:position)
//        anchorEntity.addChild(modelEntity)
//
//        arView?.scene.addAnchor(anchorEntity)
//
//    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

extension ARView {
    
    func enableTapGesture(){
        let tapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    func handleTap(recognizer: UITapGestureRecognizer){
        print("HANDLING")
//        let tapLocation = recognizer.location(in: self)
        let tapLocation = self.center
        
//        guard let rayResult = self.ray(through: tapLocation) else {return}
        
        let results = self.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any)
        
        if let firstResult = results.first {
            let position = simd_make_float3(firstResult.worldTransform.columns.3)
            placeCube(at:position)
        }
    }
    
    func placeCube(at position: SIMD3<Float>){
        let mesh = MeshResource.generateSphere(radius: 0.01)
        let material = SimpleMaterial(color: .red, roughness: 0.3, isMetallic: true)
        let modelEntity = ModelEntity(mesh: mesh,materials: [material])
        
        modelEntity.generateCollisionShapes(recursive: true)
        
        let anchorEntity = AnchorEntity(world:position)
        anchorEntity.addChild(modelEntity)
        
        self.scene.addAnchor(anchorEntity)
        
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
