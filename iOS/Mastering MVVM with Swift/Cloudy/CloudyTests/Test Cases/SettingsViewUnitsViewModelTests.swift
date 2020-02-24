//
//  SettingsViewUnitsViewModel.swift
//  CloudyTests
//
//  Created by Roman Bogun on 24.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class SettingsViewUnitsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.unitsNotation)
    }
    
    func testText_ImperialUnit() {
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .imperial)
        XCTAssertEqual(viewModel.text, "Imperial")
    }
    
    func testText_MetricUnit() {
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .metric)
        XCTAssertEqual(viewModel.text, "Metric")
    }
    
    func testIsChecked_Imperial_Imperial() {
        let unitNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: unitNotation)
        XCTAssertTrue(viewModel.isChecked)
    }
    
    func testIsNotChecked_Imperial_Metric() {
        let unitNotation: UnitsNotation = .imperial
        UserDefaults.standard.set(unitNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .metric)
        XCTAssertFalse(viewModel.isChecked)
    }
    
    func testIsChecked_Metric_Metric() {
        let unitNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: unitNotation)
        XCTAssertTrue(viewModel.isChecked)
    }
    
    func testIsChecked_Metric_Imperial() {
        let unitNotation: UnitsNotation = .metric
        UserDefaults.standard.set(unitNotation.rawValue, forKey: UserDefaultsKeys.unitsNotation)
        let viewModel = SettingsViewUnitsViewModel(unitsNotation: .imperial)
        XCTAssertFalse(viewModel.isChecked)
    }
    
}
