//
//  CGRect+Extensions.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 17/02/23.
//

import Foundation

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: (minX + maxX) / 2, y: (minY + maxY) / 2)
    }
}
