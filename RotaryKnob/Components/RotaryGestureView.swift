//
//  RotaryGestureView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 16/02/23.
//

import SwiftUI

struct RotaryGestureView<Content: View>: View {
    @Binding var angle: Angle
    let content: () -> Content
    
    @State private var gestureContainer = AppGesture()
    @State private var center: CGPoint = .zero
    
    var body: some View {
        GestureView(gestureContainer: $gestureContainer) {
            content()
        }
        .readSize { size in
            center = size.center
        }
        .onChange(of: gestureContainer) { newValue in
            if newValue.isActive {
                let rotation = newValue.endPoint.angle(around: center)
                
                angle = Angle(radians: rotation)
            }
        }
    }
}

fileprivate struct GestureView<Content: View>: View {
    @Binding var gestureContainer: AppGesture
    let content: () -> Content
    
    var body: some View {
        SpacerView {
            content()
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
    }
    
    private struct SpacerView<Content: View>: View {
        let backgroundColor: Color
        let content: () -> Content
        
        init(backgroundColor: Color = .white, content: @escaping () -> Content) {
            self.backgroundColor = backgroundColor
            self.content = content
        }
        
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
            .background(backgroundColor)
        }
    }
}
