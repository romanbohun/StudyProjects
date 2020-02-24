//
//  SettingsViewTemperatureViewModel.swift
//  Cloudy
//
//  Created by Roman Bogun on 24.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import Foundation

struct SettingsViewTemperatureViewModel: SettingsRepresentable {
    
    let temperatureNotation: TemperatureNotation
    
    var text: String {
        switch temperatureNotation {
        case .fahrenheit:
            return "Fahrenheit"
        case .celsius:
            return "Celcius"
        }
    }
    
    var isChecked: Bool {
        return UserDefaults.temperatureNotation() == temperatureNotation
    }
    
}
