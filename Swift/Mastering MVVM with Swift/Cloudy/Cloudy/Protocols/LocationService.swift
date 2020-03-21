//
//  LocationServiceProtocol.swift
//  Cloudy
//
//  Created by Roman Bogun on 20.03.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import Foundation

typealias LocationServiceCompletionHandler = ([Location], Error?) -> Void

protocol LocationService {
    func geocode(addressString: String?, completionHandler: @escaping LocationServiceCompletionHandler)
}
