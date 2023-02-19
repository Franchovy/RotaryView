//
//  Angle+Extensions.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 19/02/23.
//

import SwiftUI

extension Angle {
    static var zero: Angle {
        Angle(radians: 0)
    }
    
    static var circumference: Angle {
        Angle(radians: 2 * .pi)
    }
    
    static var halfCircumference: Angle {
        Angle(radians: .pi)
    }
}

extension Angle {
    func normalized() -> Angle {
        if self < .zero {
            return (self + .circumference).normalized()
        } else if self > .circumference {
            return (self - .circumference).normalized()
        } else {
            return self
        }
    }
}
