//
//  RotaryKnob.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 15/02/23.
//

import SwiftUI

struct RotaryKnob: View {
    let rotation: CGFloat
    
    var body: some View {
        Circle()
            .fill(Color.blacksmooth)
            .frame(size: .marginLarger)
            .overlay (alignment: .top) {
                Circle()
                    .fill(Color.whitesmoke)
                    .frame(size: .marginTiny)
                    .padding(.marginTiny)
            }
            .rotationEffect(.init(radians: rotation.double))
    }
}

struct RotaryKnob_Previews: PreviewProvider {
    static var previews: some View {
        RotaryKnob(rotation: .pi / 4)
    }
}
