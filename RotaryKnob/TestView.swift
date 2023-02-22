//
//  TestView.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 18/02/23.
//

import SwiftUI

struct TestView: View {
    @State var startAngle: Double
    @State var sensitivity: Int
    
    @State var inputStartAngle: Double
    @State var inputSensitivity: Int
    
    @State var state: RotaryView.State = .init(speed: 0, angularSpeed: 0, angle: 0)
    
    init(startAngle: Double, sensitivity: Int) {
        self.startAngle = startAngle
        self.sensitivity = sensitivity
        self.inputStartAngle = startAngle
        self.inputSensitivity = sensitivity
        
        let state = RotaryView.State(speed: .zero, angularSpeed: .zero, angle: .zero)
        self.state = state
    }
    
    var body: some View {
        HStack {
            VStack (spacing: 5) {
                Text("Initializer properties")
                    .font(.title3)
                
                LabelledNumericalTextField(title: "Start Angle (deg.)", value: $inputStartAngle)
                LabelledNumericalTextField(title: "Sensitivity (1-10)", value: $inputSensitivity, formatter: .ranged(min: 1, max: 10))
                
                Button("Reset") {
                    resetState(sensitivity: inputSensitivity, startAngle: inputStartAngle)
                }
                
                Spacer()
                    .frame(maxHeight: 15)
                
                Text("Live properties (State)")
                    .font(.title3)
                
                LabelledNumericalTextField(title: "Speed (px. per second)", value: $state.speed)
                LabelledNumericalTextField(title: "Angular Speed (deg. per second)", value: $state.angularSpeed)
                LabelledNumericalTextField(title: "Angle (deg.)", value: $state.angle)
            }
            
            RotaryView(sensitivity: sensitivity, startAngle: startAngle, state: $state)
                .background(.white)
                .frame(width: 400, height: 400)
        }
        .frame(width: 600)
    }
    
    private func cleanInput() {
        if inputSensitivity > 10 { inputSensitivity = 10 }
        if inputSensitivity < 1 { inputSensitivity = 1 }
    }
    
    private func resetState(sensitivity: Int, startAngle: Double) {
        self.sensitivity = sensitivity
        self.startAngle = startAngle
        
        self.state = .init(angle: startAngle)
    }
}

fileprivate extension RotaryView.State {
    init(angle: Double) {
        self.speed = .zero
        self.angularSpeed = .zero
        self.angle = angle
    }
}
