//
//  DragGestureContainer.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 17/02/23.
//

import SwiftUI

struct DragGestureContainer {
    var isActive: Bool = false
    var gesture: DragGesture.Value? = nil
    var previousLocation: CGPoint? = nil
    var previousTime: Date? = nil
    
    mutating func began(_ gesture: DragGesture.Value) {
        isActive = true
        previousLocation = nil
        previousTime = nil
        self.gesture = gesture
    }
    
    mutating func updated(_ gesture: DragGesture.Value) {
        previousLocation = self.gesture!.location
        previousTime = self.gesture!.time
        
        self.gesture = gesture
    }
    
    mutating func ended(_ gesture: DragGesture.Value) {
        updated(gesture)
        
        isActive = false
    }
}

extension DragGestureContainer {
    var timeInterval: TimeInterval? {
        if let previousTime {
            return gesture?.time.timeIntervalSince(previousTime)
        }
        return nil
    }
    
    func angularChange(around center: CGPoint) -> Angle? {
        if let gesture, let previousLocation {
            return Angle(radians: gesture.location.angle(around: center)
                         - previousLocation.angle(around: center))
        } else if gesture != nil {
            return Angle(radians: 0)
        }
        return nil
    }
}

extension DragGestureContainer: Equatable {
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.gesture == rhs.gesture
            && lhs.previousTime == rhs.previousTime
            && lhs.previousLocation == rhs.previousLocation
    }
}
