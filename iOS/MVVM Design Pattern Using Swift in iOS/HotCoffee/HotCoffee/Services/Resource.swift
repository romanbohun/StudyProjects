//
//  Resource.swift
//  HotCoffee
//
//  Created by Roman Bogun on 12.02.2020.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

struct Resource<T: Codable> {
    
    let url: URL
    var body: Data? = nil
    
}
