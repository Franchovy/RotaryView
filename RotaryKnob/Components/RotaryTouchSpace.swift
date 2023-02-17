//
//  RotaryTouchSpace.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 16/02/23.
//

import SwiftUI

fileprivate extension GestureContainer {
    
    func rotation(around point: CGPoint) -> CGFloat? {
        guard isActive else {
            return nil
        }
        
        let pointRelative = (point - endPoint)
        let offset = pointRelative.x > 0 ? .pi : 0
        
        return offset - pointRelative.atan()
    }
}

struct RotaryTouchSpace<Content: View>: View {
    @Binding var angle: Angle
    let content: () -> Content
    
    @State private var gestureContainer = GestureContainer()
    @State private var center: CGPoint = .zero
    
    var body: some View {
        TouchSpace(gestureContainer: $gestureContainer) {
            content()
        }
        .readSize { size in
            center = size.center
        }
        .onChange(of: gestureContainer) { newValue in
            if let rotation = newValue.rotation(around: center) {
                angle = Angle(radians: rotation)
            }
        }
    }
}

