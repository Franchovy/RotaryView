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
    @SwiftUI.State var angle: Angle
    @Binding var state: State
    
    @SwiftUI.State private var center: CGPoint = .zero
    @SwiftUI.State private var previousAngle: Angle = .zero
    
    init(sensitivity: Int, startAngle: Double, state: Binding<State>) {
        self.sensitivity = sensitivity
        self.angle = Angle(radians: startAngle)
        self._state = state
    }
    
    var body: some View {
        GestureView { gesture in
            KnobView()
                .rotationEffect(
                    Angle(radians: .pi / 2 - gesture.angle(around: center))
                )
                .onChange(of: gesture) {
                    if gesture.isActive {
                        previousAngle = angle
                        angle = Angle(radians: $0.angle(around: center))
                    }
                }
        }
        .readSize { size in
            center = size.center
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
