//
//  CGSize+Extensions.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 22/02/23.
//

import Foundation

extension CGSize {
    var distance: Double {
        sqrt(pow(Double(width), 2) + pow(Double(height), 2))
    }
}
