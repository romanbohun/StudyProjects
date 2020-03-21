//
//  OrderViewModel.swift
//  HotCoffee
//
//  Created by Roman Bogun on 12.02.2020.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

struct OrderViewModel {
    
    let order: Order
    
    var name: String {
        return order.name
    }
    var email: String {
        return order.email
    }
    var type: String {
        return order.type.rawValue.capitalized
    }
    var size: String {
        return order.size.rawValue.capitalized
    }
    
}
