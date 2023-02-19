//
//  LabelledNumericalTextField.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 19/02/23.
//

import SwiftUI

struct LabelledNumericalTextField<T: Numeric>: View {
    let title: String
    let hint: String
    let formatter: Formatter
    @Binding var value: T
    
    init (title: String, hint: String? = nil, value: Binding<T>, formatter: Formatter? = nil) {
        self.title = title
        self.hint = hint ?? title
        self._value = value
        self.formatter = formatter ?? .number
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.system(size: 12, weight: .semibold))
            
            TextField(hint, value: $value, formatter: formatter)
        }
    }
}
