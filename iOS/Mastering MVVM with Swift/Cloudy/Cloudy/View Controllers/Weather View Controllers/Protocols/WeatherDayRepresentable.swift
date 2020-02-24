//
//  WeatherDayRepresentable.swift
//  Cloudy
//
//  Created by Roman Bogun on 24.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import Foundation

protocol WeatherDayRepresentable {
    
    var day: String { get }
    var date: String { get }
    var iconName: String { get }
    var windSpeed: String { get }
    var temperature: String { get }
    
}
