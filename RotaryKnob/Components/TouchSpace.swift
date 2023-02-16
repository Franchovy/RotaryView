//
//  TouchSpace.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 16/02/23.
//

import SwiftUI

struct TouchSpace<Content: View>: View {
    @Binding var point: CGPoint
    let content: () -> Content
    
    var body: some View {
        VStack (alignment: .center) {
            HStack(alignment: .center) {
                content()
            }
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    point = gesture.location
                }
        )
    }
}
