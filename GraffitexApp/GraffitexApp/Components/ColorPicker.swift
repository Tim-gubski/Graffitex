//
//  ColorPicker.swift
//  GraffitexApp
//
//  Created by Bharath Anand on 2022-09-17.
//

import SwiftUI

struct ColorPick: View {
    @State var bgColor = Color.red.opacity(0.0)
    let defaults = UserDefaults.standard
    var body: some View {
        VStack {
            ColorPicker("", selection: $bgColor)
                .labelsHidden()
                .scaleEffect(CGSize(width: 1.6, height: 1.6))
                .offset(x: 15)
                .onChange(of: bgColor){
                    tag in defaults.set(tag.description, forKey: DefaultsKeys.color)
                    print(tag)
                }
        }
        .frame(width: 60)
        //.background(bgColor)
        //var selectedColor = $bgColor
    }
}

struct Slide: View {
    @State var sliderValue: Double = 0
    let defaults = UserDefaults.standard
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                //.foregroundColor(selectedColor)
                .font(.system(size: 15))
            Slider(value: $sliderValue, in: 0.01...0.05, step: 0.01)
                    .accentColor(Color.white)
                    .onChange(of: sliderValue){
                        tag in defaults.set(tag, forKey: DefaultsKeys.thicc)
                    }
            Image(systemName: "circle.fill")
                //.foregroundColor(selectedColor)
                .font(.system(size: 35))
        }.offset(x: -10)
    }
}
