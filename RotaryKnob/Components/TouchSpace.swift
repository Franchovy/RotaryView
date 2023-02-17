//
//  TouchSpace.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 16/02/23.
//

import SwiftUI

struct TouchSpace<Content: View>: View {
    @Binding var gestureContainer: GestureContainer
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
        .background(.white)
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
}
