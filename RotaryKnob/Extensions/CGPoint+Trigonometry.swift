//
//  CGPoint+Trigonometry.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 17/02/23.
//

import Foundation

extension CGPoint {
    func atan() -> CGFloat {
        return Darwin.atan(y / x)
    }
}
