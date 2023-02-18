//
//  ContentView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 15/02/23.
//

import SwiftUI

struct ContentView: View {
    @State var state = RotaryView.State(speed: 0, angularSpeed: 0, angle: 0)
    
    var body: some View {
        RotaryView(sensitivity: 3, startAngle: 45, state: $state)
            .background(.white)
            .frame(width: 400, height: 400)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
