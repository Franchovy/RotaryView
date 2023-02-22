//
//  RotationalGestureView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 16/02/23.
//

import SwiftUI

struct GestureView<Content: View>: View {
    let coordinateSpace: CoordinateSpace?
    let content: (DragGestureContainer) -> Content
    
    @State private var gesture = DragGestureContainer()
    
    init(coordinateSpace: CoordinateSpace? = nil, content: @escaping (DragGestureContainer) -> Content) {
        self.coordinateSpace = coordinateSpace
        self.content = content
    }
    
    var body: some View {
        SpacerView {
            content(gesture)
                .gesture(
                    DragGesture(coordinateSpace: .global)
                        .onChanged {
                            if !gesture.isActive {
                                gesture.began($0)
                            } else {
                                gesture.updated($0)
                            }
                        }
                        .onEnded {
                            gesture.ended($0)
                        }
                )
        }
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
