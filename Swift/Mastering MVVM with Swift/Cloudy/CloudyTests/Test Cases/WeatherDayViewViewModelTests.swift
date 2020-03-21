//
//  WeatherDayViewViewModelTests.swift
//  CloudyTests
//
//  Created by Roman Bogun on 28.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class WeatherDayViewViewModelTests: XCTestCase {
    
    var viewModel: WeatherDayViewViewModel!
    
    override func setUp() {
        super.setUp()
        let data = loadStubsFromBundle(with: "darksky", extension: "json")!
        let weatherData: WeatherData = try! JSONDecoder.decode(data: data)
        viewModel = WeatherDayViewViewModel(weatherDayData: weatherData.dailyData[5])
    }
    
    override func tearDown() {
        super.tearDown()
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureNotation)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unitsNotation)
    }
    
    func testDay() {
        XCTAssertEqual(viewModel.day, "Saturday")
    }
    
    func testDate() {
        XCTAssertEqual(viewModel.date, "July 15")
    }
    
    func testTemperature_Fahrenheit() {
        UserDefaults.setTemperatureNotation(temperatureNotation: .fahrenheit)
        XCTAssertEqual(viewModel.temperature, "37 ºF - 47 ºF")
    }
    
    func testTemperature_Celsius() {
        UserDefaults.setTemperatureNotation(temperatureNotation: .celsius)
        XCTAssertEqual(viewModel.temperature, "3 ºC - 8 ºC")
    }
    
    func testWindSpeed_Imperial() {
        UserDefaults.setUnitsNotation(unitsNotation: .imperial)
        XCTAssertEqual(viewModel.windSpeed, "1 MPH")
    }
    
    func testWindSpeed_Metric() {
        UserDefaults.setUnitsNotation(unitsNotation: .metric)
        XCTAssertEqual(viewModel.windSpeed, "2 KPH")
    }
    
    func testIconName() {
        let viewModelImage = UIImage.imageForIconName(withName: viewModel.iconName)!
        let imageDataViewModel = viewModelImage.pngData()
        let imageDataReference = UIImage.imageForIconName(withName: "partly-cloudy-night")!.pngData()
        
        XCTAssertEqual(viewModel.iconName, "partly-cloudy-night")
        XCTAssertEqual(viewModelImage.size.width, 236.0)
        XCTAssertEqual(viewModelImage.size.height, 172.0)
        XCTAssertEqual(imageDataViewModel, imageDataReference)
    }
    
}
