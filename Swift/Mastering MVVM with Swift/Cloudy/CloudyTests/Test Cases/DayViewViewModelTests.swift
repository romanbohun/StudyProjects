//
//  DayViewViewModelTests.swift
//  CloudyTests
//
//  Created by Roman Bogun on 28.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import XCTest
import UIKit
@testable import Cloudy

class DayViewViewModelTests: XCTestCase {
    
    var viewModel: DayViewViewModel!
    
    override func setUp() {
        super.setUp()
        
        let data = loadStubsFromBundle(with: "darksky", extension: "json")!
        let weatherData: WeatherData = try! JSONDecoder.decode(data: data)
        viewModel = DayViewViewModel(weatherData: weatherData)
    }

    override func tearDown() {
        super.tearDown()
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.timeNotation)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unitsNotation)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureNotation)
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "Tue, July 11")
    }
    
    func testTime_TwelveHour() {
        UserDefaults.setTimeNotation(timeNotation: .twelveHour)
        XCTAssertEqual(viewModel.time, "02:57 PM")
    }
    
    func testTime_TwentyFourHour() {
        UserDefaults.setTimeNotation(timeNotation: .twentyFourHour)
        XCTAssertEqual(viewModel.time, "14:57")
    }
    
    func testSummary() {
        XCTAssertEqual(viewModel.summary, "Clear")
    }
    
    func testTemperature_Fahrenheit() {
        UserDefaults.setTemperatureNotation(temperatureNotation: .fahrenheit)
        XCTAssertEqual(viewModel.temperature, "44.5 ºF")
    }
    
    func testTemperature_Celsius() {
        UserDefaults.setTemperatureNotation(temperatureNotation: .celsius)
        XCTAssertEqual(viewModel.temperature, "6.9 ºC")
    }
    
    func testWindSpeed_Imperial() {
        UserDefaults.setUnitsNotation(unitsNotation: .imperial)
        XCTAssertEqual(viewModel.windSpeed, "6 MPH")
    }
    
    func testWindSpeed_Metric() {
        UserDefaults.setUnitsNotation(unitsNotation: .metric)
        XCTAssertEqual(viewModel.windSpeed, "10 KPH")
    }
    
    func testIcon_IconName() {
        let viewModelImage = UIImage.imageForIconName(withName: viewModel.iconName)!
        let imageDataViewModel = viewModelImage.pngData()
        let imageDataReference = UIImage.imageForIconName(withName: "clear-day")!.pngData()
        
        XCTAssertEqual(viewModel.iconName, "clear-day")
        XCTAssertEqual(viewModelImage.size.width, 236.0)
        XCTAssertEqual(viewModelImage.size.height, 236.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }
    
}
