//
//  RotaryView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 18/02/23.
//

import SwiftUI

let INPUT_SENSITIVITY: Double = 0.04
let INNER_RADIUS_IGNORED_SIZE: Double = 4.0
let GESTURE_INPUT_MARGIN: CGFloat = .marginSmall

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
    
    @Binding var state: Self.State
    
    @SwiftUI.State private var previousGesture: DragGesture.Value?
    @SwiftUI.State private var center: CGPoint = .zero
    @SwiftUI.State private var proxy: GeometryProxy?
    
    init(sensitivity: Int, startAngle: Double, state: Binding<State>) {
        self.sensitivity = Double(sensitivity) * INPUT_SENSITIVITY
        self.startAngle = startAngle
        
        self._state = state
    }
    
    var body: some View {
        KnobView()
            .rotationEffect(
                Angle(degrees: state.angle + startAngle)
            )
            .readGeometry {
                proxy = $0
            }
            .padding(GESTURE_INPUT_MARGIN)
            .overlay(
                Color.clear
                    .contentShape(Circle())
                    .gesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .global)
                            .onChanged {
                                gestureChanged($0)
                                previousGesture = $0
                            }.onEnded {
                                gestureEnded($0)
                                previousGesture = nil
                            })
            )
    }
    
    private func gestureChanged(_ gesture: DragGesture.Value) {
        
        // Ignore movements inside the rotational knob
        guard let frame = proxy?.frame(in: .global),
              frame.center.distanceTo(gesture.location) > INNER_RADIUS_IGNORED_SIZE
        else {
            return
        }
        
        if let previousGesture {
            // Gesture update
            
            let timeInterval = gesture.time.timeIntervalSince(previousGesture.time)
            let angularChange = Angle.subtractNormalized(
                lhs: Angle(radians: gesture.location.angle(around: frame.center)),
                rhs: Angle(radians: previousGesture.location.angle(around: frame.center))
            )
            
            // Ignore small time intervals to avoid "jumpy" behaviour
            guard timeInterval > 0.007 else { state = state.stopped; return }
            
            let angularSpeed = angularChange / timeInterval
            let speed = angularSpeed * (sensitivity / 10)
            let angle = Angle(degrees: state.angle + speed.degrees).normalized()
            
            state = State(
                speed: Int(speed.degrees),
                angularSpeed: angularSpeed.degrees,
                angle: angle.degrees
            )
        } else {
            // Gesture Start
            
            state = state.stopped
        }
    }
    
    private func gestureEnded(_ gesture: DragGesture.Value) {
        state = state.stopped
        previousGesture = nil
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
