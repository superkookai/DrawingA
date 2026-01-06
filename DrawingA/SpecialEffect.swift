//
//  SpecialEffect.swift
//  DrawingA
//
//  Created by Weerawut on 6/1/2569 BE.
//

import SwiftUI

struct SpecialEffect: View {
    var body: some View {
//        ZStack {
//            Image(.example)
//                .resizable()
//            
//            Rectangle()
//                .fill(.blue)
//                .blendMode(.multiply)
//        }
        Image(.example)
            .resizable()
            .colorMultiply(.green)
        .frame(width: 400, height: 300)
    }
}

#Preview {
    SpecialEffect()
}
