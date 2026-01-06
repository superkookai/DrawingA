//
//  ArrowView.swift
//  DrawingA
//
//  Created by Weerawut on 6/1/2569 BE.
//

import SwiftUI

struct ArrowView: View {
    @State private var arrowLength: CGFloat = 80
    
    var body: some View {
        Arrow(arrowLength: arrowLength)
            .fill(.blue.gradient)
            .frame(width: 100, height: 50)
            .animation(.spring(), value: arrowLength)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                    arrowLength -= 5
                    if arrowLength < 20 {
                        arrowLength = 80
                    }
                }
            }
    }
}

#Preview {
    ArrowView()
}

struct Arrow: Shape {
    var animatableData: CGFloat {
        get { arrowLength }
        set { arrowLength = newValue }
    }
    
    var arrowLength = CGFloat(100)
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: (rect.height-rect.height*0.5)/2))
            path.addLine(to: CGPoint(x: rect.maxX - arrowLength, y: (rect.height-rect.height*0.5)/2))
            path.addLine(to: CGPoint(x: rect.maxX - arrowLength, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height/2))
            path.addLine(to: CGPoint(x: rect.maxX - arrowLength, y: rect.height))
            path.addLine(to: CGPoint(x: rect.maxX - arrowLength, y: rect.height-(rect.height-rect.height*0.5)/2))
            path.addLine(to: CGPoint(x: 0, y: rect.height-(rect.height-rect.height*0.5)/2))
            path.closeSubpath()
            
        }
    }
}

#Preview("Offset Arrow") {
    TryAnimateArrow()
}

struct TryAnimateArrow: View {
    @State private var animateViewIn = false
    
    var body: some View {
        VStack {
            Arrow(arrowLength: 50)
                .fill(.red.gradient)
                .offset(x: animateViewIn ? 0 : -80)
                .frame(width: 100, height: 50)
        }
        .frame(width: 300, height: 300)
        .onAppear {
            withAnimation(.spring.repeatForever()) {
                animateViewIn = true
            }
        }
    }
}
