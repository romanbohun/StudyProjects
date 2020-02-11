//
//  ViewModelFactoryProtocol.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/16/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

protocol ViewModelFactoryProtocol {
    associatedtype T: BaseViewModel
    
    func getInstance() -> T
}
