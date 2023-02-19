//
//  View+ReadSize.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 17/02/23.
//

import SwiftUI

fileprivate struct SizePreferenceKey: PreferenceKey {
    typealias Value = GeometryProxy?
    
    static var defaultValue: GeometryProxy! = nil
    static func reduce(value: inout GeometryProxy?, nextValue: () -> GeometryProxy?) {}
}

extension View {
    
    @ViewBuilder
    func readGeometry(onChange: @escaping (GeometryProxy) -> Void) -> some View {
        self
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy)
                }
                .onPreferenceChange (SizePreferenceKey.self) {
                    if let proxy = $0 {
                        onChange(proxy)
                    }
                }
            )
    }
}

extension GeometryProxy: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.frame(in: .global) == rhs.frame(in: .global)
    }
}
