//
//  SettingsViewTemperatureViewModelTests.swift
//  CloudyTests
//
//  Created by Roman Bogun on 24.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class SettingsViewTemperatureViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureNotation)
    }
    
    func testText_FahrenheitTemperature() {
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertEqual(viewModel.text, "Fahrenheit")
    }
    
    func testText_CelciusTemperature() {
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertEqual(viewModel.text, "Celcius")
    }
    
    func testIsChecked_Fahrenheit_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: temperatureNotation)
        XCTAssertTrue(viewModel.isChecked)
    }
    
    func testIsNotChecked_Fahrenheit_Celsius() {
        let temperatureNotation: TemperatureNotation = .fahrenheit
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .celsius)
        XCTAssertFalse(viewModel.isChecked)
    }
    
    func testIsChecked_Celsius_Celsius() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: temperatureNotation)
        XCTAssertTrue(viewModel.isChecked)
    }
    
    func testIsChecked_Celsius_Fahrenheit() {
        let temperatureNotation: TemperatureNotation = .celsius
        UserDefaults.standard.set(temperatureNotation.rawValue, forKey: UserDefaultsKeys.temperatureNotation)
        let viewModel = SettingsViewTemperatureViewModel(temperatureNotation: .fahrenheit)
        XCTAssertFalse(viewModel.isChecked)
    }

}
