//
//  ColorPicker.swift
//  GraffitexApp
//
//  Created by Bharath Anand on 2022-09-17.
//

import SwiftUI

struct ColorPick: View {
    @State private var bgColor = Color.red.opacity(0.0)

    var body: some View {
        VStack {
            ColorPicker("", selection: $bgColor)
                .labelsHidden()
                .scaleEffect(CGSize(width: 1.6, height: 1.6))
                .offset(x: 15)
        }
        .frame(width: 60)
        .background(bgColor)
    }
}
