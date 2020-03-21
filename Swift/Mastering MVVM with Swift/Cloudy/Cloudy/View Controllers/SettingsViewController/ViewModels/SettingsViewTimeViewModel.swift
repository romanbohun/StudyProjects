//
//  SettingsViewTimeViewModel.swift
//  Cloudy
//
//  Created by Roman Bogun on 24.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import Foundation

struct SettingsViewTimeViewModel: SettingsRepresentable {
    
    let timeNotation: TimeNotation
    
    var text: String {
        switch timeNotation {
        case .twelveHour:
            return "12 Hour"
        case .twentyFourHour:
            return "24 Hour"
        }
    }
    
    var isChecked: Bool {
        return UserDefaults.timeNotation() == timeNotation
    }
    
}
