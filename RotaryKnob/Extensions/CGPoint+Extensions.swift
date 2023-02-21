//
//  CGPoint+Extensions.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 17/02/23.
//

import Foundation

// MARK: - Operators

extension CGPoint {
    func distanceTo(_ other: CGPoint) -> Double {
        return sqrt((self.x - other.x) * (self.x - other.x) + (self.y - other.y) * (self.y - other.y))
    }
}

extension CGPoint {
    
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
    
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
    }
}
