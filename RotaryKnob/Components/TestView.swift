//
//  TestView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 18/02/23.
//

import SwiftUI


struct TestView: View {
    @State var sensitivity: Int
    @State var startAngle: Double
    @State var state: RotaryView.State = .init(speed: .zero, angularSpeed: .zero, angle: .zero)
    
    var body: some View {
        HStack {
            VStack (spacing: 5) {
                Text("Initializer properties")
                    .font(.title3)
                
                LabelledNumericalTextField(title: "Start Angle (deg.)", value: $startAngle)
                LabelledNumericalTextField(title: "Sensitivity (1-10)", value: $sensitivity, formatter: .ranged(min: 1, max: 10))
                
                Spacer()
                    .frame(maxHeight: 15)
                
                Text("Live properties (State)")
                    .font(.title3)
                
                LabelledNumericalTextField(title: "Speed (px. per second)", value: $state.speed, disabled: true)
                LabelledNumericalTextField(title: "Angular Speed (deg. per second)", value: $state.angularSpeed, disabled: true)
                LabelledNumericalTextField(title: "Angle (deg.)", value: $state.angle, disabled: true)
            }
            
            RotaryView(sensitivity: sensitivity, startAngle: startAngle, state: $state)
                .frame(width: 400, height: 400)
                .background(.white)
        }
        .frame(width: 600)
    }
}

fileprivate extension RotaryView.State {
    init(angle: Double) {
        self.speed = .zero
        self.angularSpeed = .zero
        self.angle = angle
    }
}
