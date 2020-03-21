//
//  OrderListViewModel.swift
//  HotCoffee
//
//  Created by Roman Bogun on 12.02.2020.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

class OrderListViewModel {
    
    var ordersViewModel: [OrderViewModel] = []
    
}

extension OrderListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRows: Int {
        return ordersViewModel.count
    }
    
    func orderViewModel(at index: Int) -> OrderViewModel {
        return ordersViewModel[index]
    }
    
}
