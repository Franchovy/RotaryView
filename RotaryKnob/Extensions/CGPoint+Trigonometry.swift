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
    
    func angle(around center: CGPoint) -> CGFloat {
        let relativePoint = (center - self)
        let offset = relativePoint.x > 0 ? .pi : 0
        
        return relativePoint.inverseTangent - offset + .pi / 2
    }
}
