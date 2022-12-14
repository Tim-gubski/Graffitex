//
//  DrawingScreen.swift
//  GraffitexApp
//
//  Created by Tim Gubski on 9/17/22.
//

import SwiftUI

struct Line {
    var points = [CGPoint]()
    var color: Color = .red
    var lineWidth: Double = 1.0
}

struct DrawingScreen: View {
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var thickness: Double = 1.0
    
    var body: some View {
        Canvas { context, size in
            for line in lines {
                var path = Path()
                path.addLines(line.points)
                context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
            }
        }
        .frame(minWidth: 400, minHeight: 400)
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
        .onChanged({ value in
            let newPoint = value.location
            currentLine.points.append(newPoint)
            self.lines.append(currentLine)
          })
        .onEnded({ value in
            self.lines.append(currentLine)
            self.currentLine = Line(points: [], color: currentLine.color, lineWidth: thickness)
        }))
    }
}


