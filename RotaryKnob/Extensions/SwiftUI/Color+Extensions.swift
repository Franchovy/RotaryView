//
//  Color+Extensions.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 15/02/23.
//

import SwiftUI

extension Color {
    static var blacksmooth: Color = hex(rgb: 0x111116)
    static var whitesmoke: Color = hex(rgb: 0xf5f5f5)
}

extension Color {
    /// RGB Hexadecimal Initializer (24- bit)
    static func hex(rgb hex: Int) -> Self {
        let (r, g, b) = (hex >> 16, hex >> 8 & 0xFF, hex & 0xFF)
        
        return .init(
            red: Double(r),
            green: Double(g),
            blue: Double(b)
        )
    }
    
    /// RGB Hexadecimal Initializer (24- bit)
    static func hex(rgba hex: Int) -> Self {
        let (a, r, g, b) = (hex >> 24, hex >> 16 & 0xFF, hex >> 8 & 0xFF, hex & 0xFF)
        
        return .init(
            red: Double(r),
            green: Double(g),
            blue: Double(b),
            opacity: Double(a)
        )
    }
}
