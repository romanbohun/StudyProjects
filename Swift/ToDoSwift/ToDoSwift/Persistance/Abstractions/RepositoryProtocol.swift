//
//  RepositoryProtocol.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype T: BaseDataProtocol
    associatedtype U
    
    func getAll() -> Array<T>?
    func get(withId: U) -> T?
    
    func Add(model: T) -> T
    func Update(model: T) -> CrudResult
    func Delete(model: T) -> CrudResult
}

enum CrudResult {
    case Success
    case Failed
}
