//
//  ContentView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 15/02/23.
//

import SwiftUI

struct ContentView: View {
    @State var angle: Angle = .zero
    
    var body: some View {
        VStack(alignment: .center) {
            RotaryTouchSpace(angle: $angle) {
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
