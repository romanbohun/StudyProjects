//
//  AddLocationViewViewModelTests.swift
//  CloudyTests
//
//  Created by Roman Bogun on 20.03.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking
@testable import Cloudy

class AddLocationViewViewModelTests: XCTestCase {

    private class MockLocationService: LocationService {
        
        func geocode(addressString: String?, completionHandler: @escaping LocationServiceCompletionHandler) {
            guard let addressString = addressString, !addressString.isEmpty else {
                completionHandler([], nil)
                return
            }
            
            let location = Location(name: "Brussels", latitude: 50.8503, longitude: 4.3517)
            completionHandler([location], nil)
        }
        
    }
    
    var viewModel: AddLocationViewViewModel!
    var scheduler: SchedulerType!
    var query: BehaviorRelay<String>!
    
    override func setUp() {
        super.setUp()
        query = BehaviorRelay<String>(value: "")
        let locationService = MockLocationService()
        viewModel = AddLocationViewViewModel(query: query.asDriver(), locationService: locationService)
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testLocations_HasLocations() {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        query.accept("Brus")
        let result = try! observable.skip(1).toBlocking().first()!
        let location = result.first!
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(location.name, "Brussels")
    }
    
    func testLocations_NoLocations() {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        let result = try! observable.toBlocking().first()!
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 0)
    }
    
    func testLocationAtIndex_NonNil() {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        query.accept("Brus")
        let _ = try! observable.skip(1).toBlocking().first()!
        let result = viewModel.location(at: 0)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name, "Brussels")
    }
    
    func testLocationAtIndex_Nil() {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        query.accept("Brus")
        let _ = try! observable.skip(1).toBlocking().first()!
        let result = viewModel.location(at: 1)
        
        XCTAssertNil(result)
    }
    
    func testViewModelForLocationAtIndex_NonNil() {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        query.accept("Brus")
        let _ = try! observable.skip(1).toBlocking().first()!

        let result = viewModel.viewModelForLocation(at: 0)

        XCTAssertNotNil(result)
        XCTAssertEqual(result!.text, "Brussels")
    }

    func testViewModelForLocationAtIndex_Nil() {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        query.accept("Brus")
        let _ = try! observable.skip(1).toBlocking().first()!

        let result = viewModel.viewModelForLocation(at: 1)

        XCTAssertNil(result)
    }

    func testHasLocations_True() {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        query.accept("Brus")
        let _ = try! observable.skip(1).toBlocking().first()!

        XCTAssertTrue(viewModel.hasLocations)
    }

    func testHasLocations_False() {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        let _ = try! observable.toBlocking().first()!

        XCTAssertFalse(viewModel.hasLocations)
    }

    func testNumberOfLocations_1() {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        query.accept("Brus")
        let _ = try! observable.skip(1).toBlocking().first()!

        XCTAssertEqual(viewModel.numberOfLocations, 1)
    }

    func testNumberOfLocations_0() {
        let observable = viewModel.locations.asObservable().subscribeOn(scheduler)
        let _ = try! observable.toBlocking().first()!

        XCTAssertEqual(viewModel.numberOfLocations, 0)
    }

}
