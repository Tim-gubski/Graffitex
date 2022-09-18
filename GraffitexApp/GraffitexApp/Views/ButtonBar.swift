import SwiftUI
import CoreHaptics



struct ButtonBar: View {
    @State private var engine : CHHapticEngine?
    @State private var player : CHHapticPatternPlayer?
    @State private var vibrating = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 50) {
            Button(action: {
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }) {
                Image(systemName: "minus.diamond")
            }
            

            Button(action: {
                
            }) {
                Image(systemName: "xmark.diamond.fill")
            }.simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        // this stuff runs when first clicking the button
                        if(!vibrating){
                            vibrating = true
                            vibrate()
                            print("wtf?")
                            startAudio()
                            print("starting vibration")
                        }
                    })
                    .onEnded({ _ in
                        // this stuff runs when you let go of the button
                        do {
                            if(vibrating){
                                try player?.stop(atTime: CHHapticTimeImmediate)
                                vibrating = false
                                print("killing vibration")
                            }
                        } catch let error {
                            print("Error stopping the continuous haptic player: \(error)")
                        }
//                        print("unclicked")
                    })
            )
            
            Button(action: {
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }) {
                Image(systemName: "plus.diamond")
            }
        }
        .padding(.bottom, 15)
        .font(.system(size: 32))
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width, height: 80, alignment: .center)
        .background(Color.black)
        .opacity(0.87)
        .onAppear(perform:prepareHaptics)
    }


    func startAudio(){
        print("running!?")
        // Load a sound file URL
        guard let soundFileURL = Bundle.main.url(
            forResource: "SpraySound", withExtension: "mp3"
        ) else {
            print("no sound?")
            return
        }
        
        do{
            try AVAudioSession.sharedInstance().setCategory(
                AVAudioSession.Category.soloAmbient
            )
            try AVAudioSession.sharedInstance().setActive(true)
            
            let audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL)
            audioPlayer.play()
            print("sound?")
        }catch{
            print("error: \(error.localizedDescription)")
        }
        
        
    }
    
    func prepareHaptics(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        }catch{
            print("there was an error: \(error.localizedDescription)")
        }
    }
    
    func vibrate(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.2)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        
        let continuousEvent = CHHapticEvent(eventType: .hapticContinuous,
                                            parameters: [intensity, sharpness],
                                            relativeTime: 0,
                                            duration: 100)

        
        do{
            // Create a pattern from the continuous haptic event.
            let pattern = try CHHapticPattern(events: [continuousEvent], parameters: [])
            player = try engine?.makePlayer(with: pattern)
            
            // Create a player from the continuous haptic pattern.
            try player?.start(atTime: 0)
            
        }catch{
            print("Failed to vibrate: \(error.localizedDescription)")
        }


        
    }
}
