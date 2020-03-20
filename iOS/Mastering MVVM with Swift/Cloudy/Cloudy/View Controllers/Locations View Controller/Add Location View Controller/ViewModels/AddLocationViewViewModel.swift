//
//  AddLocationViewViewModel.swift
//  Cloudy
//
//  Created by Roman Bogun on 19.03.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AddLocationViewViewModel {
    
    // MARK: - Properties
    
    var hasLocations: Bool {
        return _locations.value.isEmpty
    }
    
    var numberOfLocations: Int {
        return _locations.value.count
    }
    
    var querying: Driver<Bool> {
        _querying.asDriver()
    }

    var locations: Driver<[Location]> {
        _locations.asDriver()
    }

    // MARK: -
    
    private let locationService: LocationService
    private let disposeBag = DisposeBag()
    
    private let _locations = BehaviorRelay<[Location]>(value: [])
    private let _querying = BehaviorRelay<Bool>(value: false)
    
    init(query: Driver<String>, locationService: LocationService) {
        self.locationService = locationService
        
        query.throttle(.milliseconds(500))
            .distinctUntilChanged()
            .drive(onNext: { [weak self] addressString in
                self?.geocode(addressString: addressString)
            })
        .disposed(by: disposeBag)
    }
    
    func location(at index: Int) -> Location? {
        guard index < _locations.value.count else { return nil }
        return _locations.value[index]
    }
    
    func viewModelForLocation(at index: Int) -> LocationRepresentable? {
        guard let location = location(at: index) else { return nil }
        return LocationsViewLocationViewModel(location: location.location, locationAsString: location.name)
    }
    
    // MARK: - Helper Methods

    private func geocode(addressString: String?) {
        guard let addressString = addressString, addressString.count > 2 else {
            _locations.accept([])
            return
        }

        _querying.accept(true)
        locationService.geocode(addressString: addressString) { [weak self] (locations, error) in
            self?._querying.accept(false)
            self?._locations.accept(locations)
            
            if let error = error {
                print("Unable to Forward Geocode Address \(error)")
            }
        }
    }
    
}
