//
//  RotaryKnobView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 15/02/23.
//

import SwiftUI

struct RotaryKnobView: View {
    let angle: Angle
    
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
            .rotationEffect(
                Angle(radians: .pi / 2) - angle
            )
    }
}

struct RotaryKnobView_Previews: PreviewProvider {
    static var previews: some View {
        RotaryKnobView(angle: .init(radians: .pi / 4))
    }
}
