//
//  ContentView.swift
//  GraffitexApp
//
//  Created by Tim Gubski on 9/17/22.
//

import SwiftUI
import RealityKit
import ARKit
import CoreMotion

struct DefaultsKeys {
    static let buttonPressed = "false"
}

struct ContentView : View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var y1: Double = 0.001
    @State private var y2: Double = 0.001
    @State private var y3: Double = 0.001
    @State private var delta1: Double = 0.0
    @State private var delta2: Double = 0.0
    @State private var sign1: Int = 0
    @State private var sign2: Int = 0
    
    var body: some View {
        return ZStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
//                DrawingScreen()
                ButtonBarUpper()
                ButtonBarLower()
                
            }.onAppear{
                // Create a CMMotionManager instance
                let manager = CMMotionManager()

                // Read the most recent accelerometer value

                // How frequently to read accelerometer updates, in seconds
                manager.accelerometerUpdateInterval = 0.08

                // Start accelerometer updates on a specific thread
                manager.startAccelerometerUpdates(to: .main) { (data, error) in
                    if let accelerometerData = manager.accelerometerData {
//                        print(accelerometerData.acceleration.x,
//                              accelerometerData.acceleration.y,
//                              accelerometerData.acceleration.z)
//                        if(abs(accelerometerData.acceleration.x)>1.5 || abs(accelerometerData.acceleration.y)>1.5 ||
//                           abs(accelerometerData.acceleration.z)>1.5){
//                            print("MAKE NOISE")
//                            startAudio()
//                        }
                        do{
                            y1 = y2
                            y2 = y3
                            y3 = accelerometerData.acceleration.y
                            delta1 = y2-y1
                            delta2 = y3-y2
                            sign1 = Int(delta1/abs(delta1+1e-14))
                            sign2 = Int(delta2/abs(delta2+1e-14))
                            if ((min(abs(delta1),abs(delta2)) > 2) && (sign1 != sign2)) {
                                startAudio()
                            }
                        }catch{
                            print("error \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
//
    }
    
    func startAudio(){
        // Load a local sound file
        guard let soundFileURL = Bundle.main.url(
            forResource: "ballSound",
            withExtension: "mp3"
        ) else {
            return
        }
        
        do {
            // Configure and activate the AVAudioSession
            try AVAudioSession.sharedInstance().setCategory(
                AVAudioSession.Category.playback
            )

            try AVAudioSession.sharedInstance().setActive(true)

            // Play a sound
            audioPlayer = try AVAudioPlayer(
                contentsOf: soundFileURL
            )
            audioPlayer?.numberOfLoops = 1
            audioPlayer?.play()
        }
        catch {
            print("error \(error.localizedDescription)")
        }
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
        
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            let defaults = UserDefaults.standard
            if let buttonPressed = defaults.string(forKey: DefaultsKeys.buttonPressed) {
                if(buttonPressed=="true"){
                    let results = self.raycast(from: self.center, allowing: .estimatedPlane, alignment: .any)
                    if let firstResult = results.first {
                        let position = simd_make_float3(firstResult.worldTransform.columns.3)
                        self.placeCube(at:position)
                    }
                }
            }
        }
    }
    
    @objc
    func handleTap(recognizer: UITapGestureRecognizer){
//        let tapLocation = recognizer.location(in: self)
        let tapLocation = self.center
        
//        guard let rayResult = self.ray(through: tapLocation) else {return}
        
        let results = self.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any)
        
        if let firstResult = results.first {
            let position = simd_make_float3(firstResult.worldTransform.columns.3)
//            placeCube()
        }
    }
    
    func placeCube(at position: SIMD3<Float>){
        let mesh = MeshResource.generateSphere(radius: 0.01)
        let material = SimpleMaterial(color: .red, roughness: 0.3, isMetallic: true)
        let modelEntity = ModelEntity(mesh: mesh,materials: [material])
        
        modelEntity.generateCollisionShapes(recursive: true)
        
        let translate = float4x4(
                [1,0,0,0],
                [0,1,0,0],
                [0,0,1,0],
                [0,0,-1,1]
              )
        
        let anchorEntity = AnchorEntity(world:position)
        anchorEntity.addChild(modelEntity)
//        print()
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
