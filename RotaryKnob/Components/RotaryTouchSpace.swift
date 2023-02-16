//
//  RotaryTouchSpace.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 16/02/23.
//

import SwiftUI

struct RotaryTouchSpace<Content: View>: View {
    @Binding var rotation: CGFloat
    @State var point: CGPoint = .zero
    
    let content: () -> Content
    
    var body: some View {
        TouchSpace(point: $point) {
            content()
        }
        .onGestureRotation { angle in
            print(angle)
            rotation = angle
        }
    }
}

