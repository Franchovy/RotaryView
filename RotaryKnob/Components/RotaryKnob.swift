//
//  RotaryKnob.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 15/02/23.
//

import SwiftUI

struct RotaryKnob: View {
    var body: some View {
        Circle()
            .fill(.black)
            .frame(size: .marginLarger)
            .overlay (alignment: .top) {
                Circle()
                    .fill(Color.whitesmoke)
                    .frame(size: .marginTiny)
                    .padding(.marginTiny)
            }
    }
}

struct RotaryKnob_Previews: PreviewProvider {
    static var previews: some View {
        RotaryKnob()
    }
}
