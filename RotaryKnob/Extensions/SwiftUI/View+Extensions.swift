//
//  View+Extensions.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 15/02/23.
//

import SwiftUI

extension View {
    func frame(size: CGFloat, alignment: Alignment = .center) -> some View {
        self
            .frame(width: size, height: size, alignment: alignment)
    }
}
