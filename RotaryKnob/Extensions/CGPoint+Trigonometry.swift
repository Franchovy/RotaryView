//
//  CGPoint+Trigonometry.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 17/02/23.
//

import Foundation

extension CGPoint {
    var inverseTangent: CGFloat {
        return atan(y / x)
    }
    
    var length: CGFloat {
        return hypot(x, y)
    }
}
