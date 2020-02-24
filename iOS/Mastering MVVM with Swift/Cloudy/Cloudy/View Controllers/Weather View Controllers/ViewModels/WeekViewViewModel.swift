//
//  WeekViewViewModel.swift
//  Cloudy
//
//  Created by Roman Bogun on 23.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import Foundation

struct WeekViewViewModel {
    
    let weatherData: [WeatherDayData]
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfDays: Int {
        return weatherData.count
    }
    
    func viewModel(for index: Int) -> WeatherDayViewViewModel {
        return WeatherDayViewViewModel(weatherDayData: weatherData[index])
    }
    
}
