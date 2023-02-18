//
//  AppDragGesture.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 17/02/23.
//

import Foundation

struct AppDragGesture {
    var isActive: Bool = false
    var startPoint: CGPoint = .zero
    var translation: CGPoint = .zero
    var endPoint: CGPoint = .zero
    
    private var previousPoint: CGPoint = .zero
    
    mutating func began(_ point: CGPoint) {
        isActive = true
        startPoint = point
        translation = .zero
        previousPoint = point
        endPoint = point
    }
    
    mutating func updated(_ point: CGPoint) {
        translation = point - startPoint
        previousPoint = endPoint
        endPoint = point
    }
    
    mutating func ended() {
        isActive = false
    }
}

extension AppDragGesture {
    func speed() -> CGFloat? {
        guard isActive else {
            return nil
        }
        
        return (endPoint - previousPoint).length
    }
    
    func angle(around center: CGPoint) -> CGFloat {
        let relativePoint = (center - endPoint)
        let offset = relativePoint.x > 0 ? .pi : 0
        
        return relativePoint.inverseTangent - offset + .pi / 2
    }
}

extension AppDragGesture: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.isActive == rhs.isActive
        && lhs.startPoint == rhs.startPoint
        && lhs.endPoint == rhs.endPoint
        && lhs.translation == rhs.translation
    }
}
