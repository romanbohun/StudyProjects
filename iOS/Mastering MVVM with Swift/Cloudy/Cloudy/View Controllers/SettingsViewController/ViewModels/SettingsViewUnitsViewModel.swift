//
//  SettingsViewUnitsViewModel.swift
//  Cloudy
//
//  Created by Roman Bogun on 24.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import Foundation

struct SettingsViewUnitsViewModel: SettingsRepresentable {
    
    let unitsNotation: UnitsNotation
    
    var text: String {
        switch unitsNotation {
        case .imperial:
            return "Imperial"
        case .metric:
            return "Metric"
        }
    }
    
    var isChecked: Bool {
        return UserDefaults.unitsNotation() == unitsNotation
    }
    
}
