//
//  RotaryView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 18/02/23.
//

import SwiftUI

extension RotaryView {
    struct State {
        let speed: Int
        let angularSpeed: Double
        let angle: Double
    }
}

struct RotaryView: View {
    let sensitivity: Double
    let offset: Angle
    
    @Binding var state: State
    
    @SwiftUI.State private var center: CGPoint = .zero
    @SwiftUI.State private var previousAngle: Angle?
    
    init(sensitivity: Int, startAngle: Double, state: Binding<State>) {
        self.sensitivity = Double(sensitivity)
        self.offset = Angle(degrees: startAngle)
        self._state = state
    }
    
    var body: some View {
        GestureView { gesture in
            KnobView()
                .rotationEffect(
                    Angle(degrees: state.angle) + offset
                )
                .onChange(of: gesture) {
                    updateState(gesture: $0)
                }
        }
        .readSize { size in
            center = size.center
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func updateState(gesture: AppDragGesture) {
        let angle = Angle(radians: gesture.angle(around: center))
        if gesture.isActive {
            let change = angle - (previousAngle ?? angle)
            
            previousAngle = angle
            state = State(
                speed: Int(sensitivity / 10 * change.degrees),
                angularSpeed: change.degrees,
                angle: state.angle + change.degrees * sensitivity
            )
        } else {
            previousAngle = nil
            
            state = State(
                speed: 0,
                angularSpeed: 0,
                angle: state.angle
            )
        }
    }
}
