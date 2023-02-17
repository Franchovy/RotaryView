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

extension View {
    
    @ViewBuilder
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        self
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
                .onPreferenceChange (SizePreferenceKey.self) {
                    onChange($0)
                }
            )
    }
}
