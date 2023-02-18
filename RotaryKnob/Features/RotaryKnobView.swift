//
//  RotaryKnobView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 15/02/23.
//

import SwiftUI

struct RotaryKnobView: View {
    @State var rotation: Angle
    @Binding var velocity: CGFloat
    
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
                Angle(radians: .pi / 2) - rotation
            )
            .onChange(of: velocity) { newValue in
                rotation += Angle(radians: newValue)
            }
    }
}

struct RotaryKnobView_Previews: PreviewProvider {
    static var previews: some View {
        RotaryKnobView(rotation: .init(radians: .pi / 4), velocity: .constant(0))
    }
}
