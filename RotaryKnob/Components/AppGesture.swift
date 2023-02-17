//
//  AppGesture.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 17/02/23.
//

import Foundation

struct AppGesture {
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

// MARK: - Public methods

extension AppGesture {
    
    func speed() -> CGFloat? {
        guard isActive else {
            return nil
        }
        
        return (endPoint - previousPoint).length
    }
    
    func rotation(around center: CGPoint) -> CGFloat? {
        guard isActive else {
            return nil
        }
        
        return angle(from: endPoint, center: center)
    }
    
    func rotationalVelocity(around center: CGPoint) -> CGFloat? {
        guard isActive else {
            return nil
        }
        
        return angle(from: endPoint, center: center)
            - angle(from: previousPoint, center: center)
    }
}

// MARK: - Private methods

extension AppGesture {
    
    private func angle(from point: CGPoint, center: CGPoint) -> CGFloat {
        let relativePoint = (center - point)
        let offset = relativePoint.x > 0 ? .pi : 0
        
        return offset - relativePoint.inverseTangent
    }
}

// MARK: - Operators

extension AppGesture: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.isActive == rhs.isActive
        && lhs.startPoint == rhs.startPoint
        && lhs.endPoint == rhs.endPoint
        && lhs.translation == rhs.translation
    }
}
