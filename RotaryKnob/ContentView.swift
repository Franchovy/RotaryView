//
//  ContentView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 15/02/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            RotaryKnob()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
