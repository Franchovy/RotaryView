//
//  View+ReadSize.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 17/02/23.
//

import SwiftUI

fileprivate struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
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
