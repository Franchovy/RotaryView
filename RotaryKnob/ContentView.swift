//
//  ContentView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 15/02/23.
//

import SwiftUI

struct ContentView: View {
    @State var angle: Angle = .zero
    @State var velocity: CGFloat = .zero
    
    var body: some View {
        VStack(alignment: .center) {
            RotaryGestureView(angle: $angle, velocity: $velocity) {
                RotaryKnobView(angle: angle)
            }
        }
        .background(.white)
        .frame(width: 400, height: 400)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
