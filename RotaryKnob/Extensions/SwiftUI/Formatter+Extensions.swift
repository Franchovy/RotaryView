//
//  Formatter+Extensions.swift
//  RotaryKnob
//
//  Created by Maxime Franchot on 19/02/23.
//

import SwiftUI

extension Formatter {
    static var number: NumberFormatter {
        return NumberFormatter()
    }
    
    static func ranged(min: Int, max: Int) -> NumericalRangedFormatter {
        return NumericalRangedFormatter(min: min, max: max)
    }
}

// This class is here because it's not important to the app, just for the TestView.
// It has also been ripped from StackOverflow :)
class NumericalRangedFormatter: Formatter {
    var min: Int
    var max: Int
    
    func clamp(with value: Int, min: Int, max: Int) -> Int{
        guard value <= max else {
            return max
        }
        
        guard value >= min else {
            return min
        }
        
        return value
    }
    
    init(min: Int, max: Int) {
        self.min = min
        self.max = max
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func string(for obj: Any?) -> String? {
        guard let number = obj as? Int else {
            return nil
        }
        
        return String(number)
    }
    
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        guard let number = Int(string) else {
            return false
        }
        
        obj?.pointee = clamp(with: number, min: self.min, max: self.max) as AnyObject
        
        return true
    }
}
