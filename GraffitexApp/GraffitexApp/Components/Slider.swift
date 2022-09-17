//
//  Slider.swift
//  GraffitexApp
//
//  Created by Bharath Anand on 2022-09-17.
//

import SwiftUI


struct Slide: View {
    @State var sliderValue: Double = 0
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill").font(.system(size: 15))
                Slider(value: $sliderValue, in: 0...20, step: 1)
                    .accentColor(Color.white)
                Image(systemName: "circle.fill").font(.system(size: 35))
//            VStack {
//                Slider(value: $sliderValue, in: 0...20)
//                //Text("Current slider value: \(sliderValue, specifier: "%.2f")")
//            }.padding()
        }.offset(x: -10)
    }
}
