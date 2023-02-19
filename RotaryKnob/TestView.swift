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
    
    @State var inputSpeed: Double
    @State var inputAngularSpeed: Double
    @State var inputAngle: Double
    
    @State var state: RotaryView.State = .init(speed: 0, angularSpeed: 0, angle: 0)
    
    init(startAngle: Double, sensitivity: Int) {
        self.startAngle = startAngle
        self.sensitivity = sensitivity
        self.inputStartAngle = startAngle
        self.inputSensitivity = sensitivity
        
        self.state = .init(speed: .zero, angularSpeed: .zero, angle: .zero)
        self.inputSpeed = .zero
        self.inputAngularSpeed = .zero
        self.inputAngle = .zero
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("Initializer properties")
                TextField("Start Angle", value: $inputStartAngle, format: .number)
                TextField("Sensitivity", value: $inputSensitivity, format: .number)
                
                Button("Reset") {
                    resetState(sensitivity: inputSensitivity, startAngle: inputStartAngle)
                }
                
                Text("Live properties (State)")
                
//                TextField("Speed", value: $inputSpeed, format: .number)
//                TextField("Angular Speed", value: $inputAngularSpeed, format: .number)
                TextField("Angle", value: $inputAngle, format: .number)
                    .onChange(of: inputAngle) { newValue in
                        state = .init(
                            angularSpeed: .zero,
                            sensitivity: sensitivity,
                            angle: inputAngle
                        )
                    }
            }
            
            RotaryView(sensitivity: sensitivity, startAngle: startAngle, state: $state)
                .background(.white)
                .frame(width: 400, height: 400)
        }
        .frame(width: 600)
    }
    
    private func resetState(sensitivity: Int, startAngle: Double) {
        self.sensitivity = sensitivity
        self.startAngle = startAngle
    }
}

fileprivate extension RotaryView.State {
    init(angularSpeed: Double, sensitivity: Int, angle: Double) {
        self.speed = Int(angularSpeed * Double(sensitivity) / 10)
        self.angularSpeed = angularSpeed
        self.angle = angle
    }
}
