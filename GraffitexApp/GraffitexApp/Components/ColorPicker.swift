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
            ColorPicker("Set the background color", selection: $bgColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(bgColor)
    }
}
