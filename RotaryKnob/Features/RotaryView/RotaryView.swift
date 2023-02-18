//
//  RotaryView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 18/02/23.
//

import SwiftUI

extension RotaryView {
    struct State {
        var speed: Int
        var angularSpeed: Double
        var angle: Double
    }
}

struct RotaryView: View {
    let sensitivity: Int
    @SwiftUI.State var rotation: Angle
    @Binding var state: State
    
    init(sensitivity: Int, startAngle: Double, state: Binding<State>) {
        self.sensitivity = sensitivity
        self.rotation = Angle(radians: startAngle)
        self._state = state
    }
    
    var body: some View {
        RotationalGestureView { gesture, angle in
            KnobView()
                .rotationEffect(
                    Angle(radians: .pi / 2) - rotation
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
