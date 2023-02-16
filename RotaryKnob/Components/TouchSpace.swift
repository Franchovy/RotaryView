//
//  TouchSpace.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 16/02/23.
//

import SwiftUI

struct GestureContainer {
    var isActive: Bool
    var startPoint: CGPoint
    var translation: CGPoint
    var endPoint: CGPoint
    
    init() {
        self.isActive = false
        (self.startPoint, self.translation, self.endPoint) = (.zero, .zero, .zero)
    }
    
    mutating func began(_ point: CGPoint) {
        isActive = true
        startPoint = point
        translation = .zero
        endPoint = point
    }
    
    mutating func updated(_ point: CGPoint) {
        translation = point - startPoint
        endPoint = point
    }
    
    mutating func ended() {
        isActive = false
    }
}

extension GestureContainer: Equatable {
    // TODO: - Equatable
}

struct TouchSpace<Content: View>: View {
    @Binding var point: CGPoint
    let content: () -> Content
    
    @State private var gestureContainer = GestureContainer()
    @State private var size: CGSize = .zero
    
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
        .background(.white)
        .gesture(
            DragGesture()
                .onChanged { dragGesture in
                    point = dragGesture.location - size.center
                    
                    if !gestureContainer.isActive {
                        gestureContainer.began(point)
                    } else {
                        gestureContainer.updated(point)
                    }
                }
                .onEnded { _ in
                    gestureContainer.ended()
                }
        )
        .background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: proxy.size)
            }
            .onPreferenceChange (SizePreferenceKey.self) { size in
                self.size = size
            }
        )
    }
}

extension TouchSpace {
    
    @ViewBuilder
    public func onGestureRotation(action: @escaping (CGFloat) -> Void) -> some View {
        self
            .onChange(of: gestureContainer) { newValue in
                if self.gestureContainer.isActive {
                    action(tanh(gestureContainer.translation.y / gestureContainer.translation.x))
                }
            }
    }
    
}
