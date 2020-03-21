//
//  Geocoder.swift
//  Cloudy
//
//  Created by Roman Bogun on 20.03.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import CoreLocation
import Foundation

class GeocoderService: LocationService {
    
    private lazy var geocoder = CLGeocoder()
    
    func geocode(addressString: String?, completionHandler: @escaping LocationServiceCompletionHandler) {
        guard let addressString = addressString, !addressString.isEmpty else {
            completionHandler([], nil)
            return
        }

        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            var locations: [Location] = []
            if let error = error {
                completionHandler([], error)
                print(error)
            } else if let placemarks = placemarks {
                locations = placemarks.compactMap({ placemark -> Location? in
                    guard let name = placemark.name,
                        let location = placemark.location else {
                            return nil
                    }
                    return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                })
            }
            completionHandler(locations, nil)
        }
    }
    
}
