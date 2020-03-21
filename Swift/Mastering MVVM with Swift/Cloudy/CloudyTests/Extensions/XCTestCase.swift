//
//  XCTestCase.swift
//  CloudyTests
//
//  Created by Roman Bogun on 28.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func loadStubsFromBundle(with name: String, extension: String) -> Data? {
        let bundle = Bundle(for: classForCoder)
        if let  url = bundle.url(forResource: name, withExtension: `extension`) {
            return try? Data(contentsOf: url)
        }
        return nil
    }
    
}
