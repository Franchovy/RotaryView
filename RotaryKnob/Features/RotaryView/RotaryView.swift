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
    
    private func updateState(gesture: DragGestureContainer) {
        if gesture.isActive {
            guard let timeInterval = gesture.timeInterval,
                  let angularChange = gesture.angularChange(around: center) else { return }
            
            // Ignore small time intervals to avoid "jumpy" behaviour
            guard timeInterval > 0.007 else { state = state.stopped; return }
            
            let angularSpeed = angularChange / timeInterval
            let speed = angularSpeed.degrees * (sensitivity / 10)
            
            state = State(
                speed: Int(speed),
                angularSpeed: angularSpeed.degrees,
                angle: state.angle + speed
            )
        } else {
            // Gesture ended
            state = state.stopped
        }
    }
}

extension RotaryView.State {
    var stopped: Self {
        return .init(
            speed: 0,
            angularSpeed: 0,
            angle: angle
        )
    }
}

extension RotaryView.State: Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.speed == rhs.speed
            && lhs.angularSpeed == rhs.angularSpeed
            && lhs.angle == rhs.angle
    }
}
