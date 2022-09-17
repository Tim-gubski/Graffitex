import SwiftUI

struct ButtonBarUpper: View {
    
    var body: some View {
        HStack(alignment: .center, spacing: 50) {
            Button(action: {
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }) {
                Image(systemName: "circle")
            }
            
        }
        //.padding(.bottom, 15)
        .font(.system(size: 100))
        .foregroundColor(.white)
        .frame(width: UIScreen.main.bounds.width, height: 80, alignment: .center)
        .background(Color.white.opacity(0.0))
        .opacity(0.87)
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
