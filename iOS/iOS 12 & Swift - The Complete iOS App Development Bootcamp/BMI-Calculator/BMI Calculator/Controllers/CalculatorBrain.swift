//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Roman Bogun on 01.12.2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    var bmi = Bmi()
    
    mutating func calculateBMI(height: Float, weight: Float) {
        guard height != 0 else {
            bmi.bmi = 0.0
            return
        }
        bmi.bmi = weight / pow(height, 2)
        
        switch bmi.bmi {
        case 0..<18.5:
            bmi.advice = "Eat more pies!"
            bmi.color = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        case 18.6...24.9:
            bmi.advice = "Fit as a fiddle!"
            bmi.color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        default:
            bmi.advice = "Eat less pies!"
            bmi.color = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
    }
}
