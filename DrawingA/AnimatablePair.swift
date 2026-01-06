//
//  AnimatablePair.swift
//  DrawingA
//
//  Created by Weerawut on 6/1/2569 BE.
//

import SwiftUI

struct AnimatablePairDemo: View {
    @State private var rows = 4
    @State private var columns = 4
    
    var body: some View {
        Checkerboard(rows: rows, columns: columns)
            .fill(Color.blue)
            .frame(width: 300, height: 300)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    if rows == 4 && columns == 4 {
                        rows = 8
                        columns = 16
                    } else {
                        rows = 4
                        columns = 4
                    }
                }
            }
    }
}

#Preview {
    AnimatablePairDemo()
}

struct Checkerboard: Shape {
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(Double(rows), Double(columns)) }
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    var rows: Int
    var columns: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // figure out how big each row/column needs to be
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)

        // loop over all rows and columns, making alternating squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)

                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }

        return path
    }
}
