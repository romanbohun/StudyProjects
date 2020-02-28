//
//  WeekViewViewModelTests.swift
//  CloudyTests
//
//  Created by Roman Bogun on 28.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class WeekViewViewModelTests: XCTestCase {
    
    var viewModel: WeekViewViewModel!
    
    override func setUp() {
        super.setUp()
        let data = loadStubsFromBundle(with: "darksky", extension: "json")!
        let weatherData: WeatherData = try! JSONDecoder.decode(data: data)
        viewModel = WeekViewViewModel(weatherData: weatherData.dailyData)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testNumberOfSections() {
        XCTAssertEqual(viewModel.numberOfSections, 1)
    }
    
    func testNumberOfDays() {
        XCTAssertEqual(viewModel.numberOfDays, 8)
    }
    
    func testViewModelForIndex() {
        let weatherDayViewViewModel = viewModel.viewModel(for: 5)
        
        XCTAssertEqual(weatherDayViewViewModel.day, "Saturday")
        XCTAssertEqual(weatherDayViewViewModel.date, "July 15")
    }
    
}
