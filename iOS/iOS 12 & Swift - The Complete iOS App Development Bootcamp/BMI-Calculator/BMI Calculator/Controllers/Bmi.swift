//
//  Bmi.swift
//  BMI Calculator
//
//  Created by Roman Bogun on 01.12.2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

struct Bmi: CustomStringConvertible {
    
    var bmi: Float = 0.0
    var advice: String = ""
    var color: UIColor = .white
    
    var description: String {
        return String(format: "%.1f - %", bmi, advice)
    }
    
}
