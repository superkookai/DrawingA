//
//  AnimatableData.swift
//  DrawingA
//
//  Created by Weerawut on 6/1/2569 BE.
//

import SwiftUI

struct AnimatableData: View {
    @State private var insetAmount: Double = 50
    
    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .padding()
            .onTapGesture {
                withAnimation {
                    insetAmount = Double.random(in: 10...90)
                }

            }
    }
}

#Preview {
    AnimatableData()
}

struct Trapezoid: Shape {
    var insetAmount: Double
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
   }
}
