//
//  GestureContainer.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 17/02/23.
//

import Foundation

struct GestureContainer {
    var isActive: Bool = false
    var startPoint: CGPoint = .zero
    var translation: CGPoint = .zero
    var endPoint: CGPoint = .zero
    
    mutating func began(_ point: CGPoint) {
        isActive = true
        startPoint = point
        translation = .zero
        endPoint = point
    }
    
    mutating func updated(_ point: CGPoint) {
        translation = point - startPoint
        endPoint = point
    }
    
    mutating func ended() {
        isActive = false
    }
}

extension GestureContainer: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.isActive == rhs.isActive
        && lhs.startPoint == rhs.startPoint
        && lhs.endPoint == rhs.endPoint
        && lhs.translation == rhs.translation
    }
}
