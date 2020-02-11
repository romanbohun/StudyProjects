//
//  TaskManagerProtocol.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

protocol TaskManagerProtocol {
    associatedtype T: BaseDataProtocol
    
    func create(task: T) -> T
    func update(task: T)
    func delete(task: T)
}
