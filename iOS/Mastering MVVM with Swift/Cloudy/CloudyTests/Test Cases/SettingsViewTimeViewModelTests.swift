//
//  SettingsViewTimeViewModelTests.swift
//  CloudyTests
//
//  Created by Roman Bogun on 24.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import XCTest
@testable import Cloudy

class SettingsViewTimeViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.timeNotation)
    }
    
    func testText_TwelveHour() {
        let viewModel = SettingsViewTimeViewModel(timeNotation: .twelveHour)
        XCTAssertEqual(viewModel.text, "12 Hour")
    }
    
    func testText_TwentyFourHour() {
        let viewModel = SettingsViewTimeViewModel(timeNotation: .twentyFourHour)
        XCTAssertEqual(viewModel.text, "24 Hour")
    }
    
    func testIsChecked_TwelveHour_TwelveHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        let viewModel = SettingsViewTimeViewModel(timeNotation: timeNotation)
        XCTAssertTrue(viewModel.isChecked)
    }
    
    func testIsNotChecked_TwelveHour_TwentyFourHour() {
        let timeNotation: TimeNotation = .twelveHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        let viewModel = SettingsViewTimeViewModel(timeNotation: .twentyFourHour)
        XCTAssertFalse(viewModel.isChecked)
    }
    
    func testIsChecked_TwentyFourHour_TwentyFourHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        let viewModel = SettingsViewTimeViewModel(timeNotation: timeNotation)
        XCTAssertTrue(viewModel.isChecked)
    }
    
    func testIsNotChecked_TwentyFourHour_TwelveHour() {
        let timeNotation: TimeNotation = .twentyFourHour
        UserDefaults.standard.set(timeNotation.rawValue, forKey: UserDefaultsKeys.timeNotation)
        let viewModel = SettingsViewTimeViewModel(timeNotation: .twelveHour)
        XCTAssertFalse(viewModel.isChecked)
    }
    
}
