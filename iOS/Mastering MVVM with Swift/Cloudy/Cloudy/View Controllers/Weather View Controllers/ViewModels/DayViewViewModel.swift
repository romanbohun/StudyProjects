//
//  DayViewViewModel.swift
//  Cloudy
//
//  Created by Roman Bogun on 23.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import Foundation

struct DayViewViewModel {
    
    let weatherData: WeatherData
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMMM d"
        return dateFormatter
    }()
    
    private let timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = UserDefaults.timeNotation().timeFormat
        return dateFormatter
    }()
    
    var date: String {
        return dateFormatter.string(from: weatherData.time)
    }
    
    var time: String {
        return timeFormatter.string(from: weatherData.time)
    }
    
    var summary: String {
        return weatherData.summary
    }
    
    var temperature: String {
        let temperature = weatherData.temperature
        
        switch UserDefaults.temperatureNotation() {
        case .fahrenheit:
            return String(format: "%.1f ºF", temperature)
        case .celsius:
            return String(format: "%.1f ºC", temperature.toCelcius())
        }
    }
    
    var windSpeed: String {
        let windSpeed = weatherData.windSpeed
        
        switch UserDefaults.unitsNotation() {
        case .imperial:
            return String(format: "%.f MPH", windSpeed)
        case .metric:
            return String(format: "%.f KPH", windSpeed.toKPH())
        }
    }
    
    var iconName: String {
        return weatherData.icon
    }
    
}
