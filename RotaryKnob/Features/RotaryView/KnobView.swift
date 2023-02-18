//
//  KnobView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 18/02/23.
//

import SwiftUI

struct KnobView: View {
    var body: some View {
        Circle()
            .fill(Color.blacksmooth)
            .frame(size: .marginLarger)
            .overlay (alignment: .top) {
                Circle()
                    .fill(Color.whitesmoke)
                    .frame(size: .marginTiny)
                    .padding(.marginTiny)
            }
    }
}
