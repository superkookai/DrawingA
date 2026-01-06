//
//  ContentView.swift
//  DrawingA
//
//  Created by Weerawut on 6/1/2569 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(.red, style: FillStyle(eoFill: true))
//                .stroke(.red, lineWidth: 1)
                .frame(width: 300, height: 300)
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40, step: 1)
                .padding([.bottom, .horizontal])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding([.bottom, .horizontal])
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.closeSubpath()
        }
    }
}

struct Arc: InsettableShape {
    //Start Degree 0 is at maxX and measure clockwise to End Degree 110, but the path addArc draw clockwise start from bottom left, if clockwise is false - it draw counterclockwise from bottom left also
    
    var animatableData: Angle {
        get { endAngle }
        set { endAngle = newValue }
    }
    
    let startAngle: Angle
    var endAngle: Angle
    let clockwise: Bool
    var insetAmount = 0.0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2 - insetAmount, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        return path
    }
}

struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: Double.pi*2, by: Double.pi/8) {
            let rotation = CGAffineTransform(rotationAngle: number)
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height/2))
            
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width/2))
            let rotatedPetal = originalPetal.applying(position)
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}


struct DrawingShape: View {
    @State private var endAngle: CGFloat = 0
    
    var body: some View {
        VStack {
            ZStack {
                Arc(startAngle: .degrees(0), endAngle: .degrees(180), clockwise: false)
                    .strokeBorder(.regularMaterial, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(180))
                    .frame(width: 200, height: 200)
                
                Arc(startAngle: .degrees(0), endAngle: .degrees(endAngle), clockwise: false)
                    .strokeBorder(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(180))
                    .frame(width: 200, height: 200)
                    .animation(.easeIn, value: endAngle)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            endAngle += 30.0
                            if endAngle > 180.0 {
                                endAngle = 0.0
                            }
                        }
                    }
            }
        }
    }
}

#Preview("Drawing Shape") {
    DrawingShape()
}
