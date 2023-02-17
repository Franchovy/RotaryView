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
    @State var previousAngle: Angle = .zero
    
    var body: some View {
        VStack(alignment: .center) {
            RotaryGestureView(angle: $angle) {
                RotaryKnobView(rotation: angle)
            }
        }
        .background(.white)
        .frame(width: 400, height: 400)
        .onChange(of: angle) { newValue in
            velocity = previousAngle.radians - newValue.radians
            previousAngle = newValue
            print(velocity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
