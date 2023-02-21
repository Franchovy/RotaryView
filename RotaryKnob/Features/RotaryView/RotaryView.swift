//
//  RotaryView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 18/02/23.
//

import SwiftUI

let INPUT_SENSITIVITY: Double = 0.05
let INNER_RADIUS_IGNORED_SIZE: Double = 4.0

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
    @SwiftUI.State private var proxy: GeometryProxy?
    
    init(sensitivity: Int, startAngle: Double, state: Binding<State>) {
        self.sensitivity = Double(sensitivity) * INPUT_SENSITIVITY
        self.offset = Angle(degrees: startAngle)
        self._state = state
    }
    
    var body: some View {
        KnobView()
            .rotationEffect(
                Angle(degrees: state.angle) + offset
            )
            .onChange(of: gesture) {
                updateState(gesture: $0)
            }
            .readGeometry {
                proxy = $0
            }
    }
    
    private func updateState(gesture: DragGestureContainer) {
        if gesture.isActive {
            // Ignore movements inside the rotational knob
            guard let frame = proxy?.frame(in: .global),
                  frame.center.distanceTo(gesture.gesture!.location) > INNER_RADIUS_IGNORED_SIZE
                else {
                return
            }
            
            guard let timeInterval = gesture.timeInterval,
                  let angularChange = gesture.angularChange(around: frame.center) else { return }
            
            // Ignore small time intervals to avoid "jumpy" behaviour
            guard timeInterval > 0.007 else { state = state.stopped; return }
            
            let angularSpeed = angularChange / timeInterval
            let speed = angularSpeed * (sensitivity / 10)
            
            state = State(
                speed: Int(speed.degrees),
                angularSpeed: angularSpeed.degrees,
                angle: Angle(degrees: state.angle + speed.degrees).normalized().degrees
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
