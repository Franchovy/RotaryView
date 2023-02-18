//
//  RotationalGestureView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 16/02/23.
//

import SwiftUI

struct RotationalGestureView<Content: View>: View {
    let content: (RotationalDragGesture, Angle) -> Content
    
    @State private var gestureContainer = RotationalDragGesture()
    @State private var angle: Angle = .zero
    @State private var center: CGPoint = .zero
    
    init(content: @escaping (RotationalDragGesture, Angle) -> Content) {
        self.content = content
    }
    
    var body: some View {
        SpacerView {
            content(gestureContainer, angle)
        }
        .readSize { size in
            center = size.center
        }
        .gesture(
            DragGesture()
                .onChanged { dragGesture in
                    if !gestureContainer.isActive {
                        gestureContainer.began(dragGesture.location)
                    } else {
                        gestureContainer.updated(dragGesture.location)
                    }
                }
                .onEnded { _ in
                    gestureContainer.ended()
                }
        )
        .onChange(of: gestureContainer) { newValue in
            if newValue.isActive {
                let rotation = newValue.endPoint.angle(around: center)
                angle = Angle(radians: rotation)
            }
        }
    }
}

extension RotationalGestureView {
    private struct SpacerView<Content: View>: View {
        let content: () -> Content
        
        var body: some View {
            VStack (alignment: .center) {
                Spacer()
                HStack(alignment: .center) {
                    Spacer()
                    
                    content()
                    
                    Spacer()
                }
                Spacer()
            }
            .contentShape(Rectangle())
        }
    }
}
