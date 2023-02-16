//
//  SizePreferenceKey.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 17/02/23.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
