//
//  AddCoffeeOrderViewModel.swift
//  HotCoffee
//
//  Created by Roman Bogun on 12.02.2020.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation

struct AddCoffeeOrderViewModel {
    
    var name: String?
    var email: String?
    var selectedType: String?
    var selectSize: String?
    
    var types: [String] {
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
    }
    
}

extension AddCoffeeOrderViewModel {
    
    var numberOfTypeSections: Int {
        return 1
    }
    
    var numberOfTypeRows: Int {
        return types.count
    }
    
}

extension AddCoffeeOrderViewModel {
    
    func orderModel() -> Order? {
        guard let nameUnwrapped = name,
            let emailUnwrapped = email,
            let selectedTypeUnwrapped = selectedType,
            let selectedSizeUnwrapped = selectSize,
            let selectedType = CoffeeType(rawValue: selectedTypeUnwrapped.lowercased()),
            let selectedSize = CoffeeSize(rawValue: selectedSizeUnwrapped.lowercased()) else {
                return nil
        }
        
        return Order(name: nameUnwrapped, email: emailUnwrapped, type: selectedType, size: selectedSize)
    }
    
}
