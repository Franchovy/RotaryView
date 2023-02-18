//
//  RotationalGestureView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 16/02/23.
//

import SwiftUI

struct GestureView<Content: View>: View {
    let content: (AppDragGesture) -> Content
    
    @State private var gesture = AppDragGesture()
    
    init(content: @escaping (AppDragGesture) -> Content) {
        self.content = content
    }
    
    var body: some View {
        SpacerView {
            content(gesture)
        }
        .gesture(
            DragGesture()
                .onChanged {
                    if !gesture.isActive {
                        gesture.began($0.location)
                    } else {
                        gesture.updated($0.location)
                    }
                }
                .onEnded { _ in
                    gesture.ended()
                }
        )
    }
}

extension GestureView {
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
