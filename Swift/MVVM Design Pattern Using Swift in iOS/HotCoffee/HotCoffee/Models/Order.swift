//
//  Order.swift
//  HotCoffee
//
//  Created by Roman Bogun on 12.02.2020.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

struct Order: Codable {
    
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
    
}
