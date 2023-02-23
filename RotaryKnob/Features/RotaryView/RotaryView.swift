//
//  RotaryView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 18/02/23.
//

import SwiftUI

let INPUT_SENSITIVITY: Double = 0.7
let INNER_RADIUS_IGNORED_SIZE: Double = 4.0

extension RotaryView {
    struct State {
        var speed: Int
        var angularSpeed: Double
        var angle: Double
    }
}

struct RotaryView: View {
    let sensitivity: Double
    let startAngle: Double
    
    @Binding var state: State
    
    @SwiftUI.State var gestureStartAngle: CGFloat = .zero
    @SwiftUI.State private var previousAngle: Angle = .zero
    @SwiftUI.State private var center: CGPoint = .zero
    @SwiftUI.State private var proxy: GeometryProxy?
    
    init(sensitivity: Int, startAngle: Double, state: Binding<State>) {
        self.sensitivity = Double(sensitivity) * INPUT_SENSITIVITY
        self.startAngle = startAngle
        
        self._state = state
    }
    
    var body: some View {
        GestureView { gesture in
            KnobView()
                .rotationEffect(
                    Angle(degrees: state.angle + startAngle)
                )
                .onChange(of: gesture) {
                    updateState(gesture: $0)
                }
                .readGeometry {
                    proxy = $0
                }
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
                  let translation = gesture.gesture?.translation.height.negated else { return }
            
            // Ignore small time intervals to avoid "jumpy" behaviour
            guard timeInterval > 0.007 else { state = state.stopped; return }
            
            let angle = Angle(degrees: gestureStartAngle + translation * (sensitivity / 10)).normalized()
            let angularSpeed = (angle - previousAngle).degrees / timeInterval
            previousAngle = angle
            
            state = State(
                speed: Int(angularSpeed * (sensitivity / 10)),
                angularSpeed: angularSpeed,
                angle: angle.degrees
            )
        } else {
            // Gesture ended
            state = state.stopped
            previousAngle = Angle(degrees: state.angle)
            gestureStartAngle = state.angle
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
