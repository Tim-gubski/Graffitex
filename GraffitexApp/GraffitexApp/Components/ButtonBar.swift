import SwiftUI
import CoreHaptics

struct ButtonBarUpper: View {
    
    @State private var engine : CHHapticEngine?
    @State private var player : CHHapticPatternPlayer?
    @State private var vibrating = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 50) {
            Button(action: {
                
            }) {
                Image(systemName: "circle")
            }.simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        if(!vibrating){
                            vibrating = true
                            vibrate()
                            print("starting vibration")
                        }
                    })
                    .onEnded({ _ in
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
            
        }
        //.padding(.bottom, 15)
        .font(.system(size: 100))
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width, height: 80, alignment: .center)
        .background(Color.white.opacity(0.0))
        .opacity(0.87)
        .onAppear(perform:prepareHaptics)
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


struct ButtonBarLower: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 50) {
//            Button(action: {
//                let impactMed = UIImpactFeedbackGenerator(style: .medium)
//                impactMed.impactOccurred()
//            }) {
//                Image(systemName: "circle")
//            }
            ColorPick()

//            Button(action: {
//                let impactMed = UIImpactFeedbackGenerator(style: .medium)
//                impactMed.impactOccurred()
//            }) {
//                Image(systemName: "xmark.diamond.fill")
//            }
            
            Slide()
                        
            
//            Button(action: {
//                let impactMed = UIImpactFeedbackGenerator(style: .medium)
//                impactMed.impactOccurred()
//            }) {
//                Image(systemName: "plus.diamond")
//            }
        }
        .padding(.bottom, 15)
        .font(.system(size: 55))
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width, height: 80, alignment: .center)
        .background(Color.white.opacity(0.0))
        .opacity(0.87)
    }
}

