//
//  TaskReadManagerProtocol.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

protocol TaskReadManagerProtocol {
    associatedtype T: BaseDataProtocol
    
    func getTasks() -> Array<T>
}
