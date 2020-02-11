//
//  BaseRepository.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

class BaseRepository: RepositoryProtocol {
    typealias T = BaseDataModel
    typealias U = String
    
    let db: Database?
    
    init(db: Database) {
        self.db = db
    }
    
    func getAll() -> Array<BaseDataModel>? {
        return db?.getTaskTable()
    }
    
    func get(withId: String) -> BaseDataModel? {
        return db?.getTaskTable().first(where: { (BaseDataModel) -> Bool in
            return BaseDataModel.id == withId
        })
    }
    
    func Add(model: BaseDataModel) -> BaseDataModel {
        let newModel = db?.add(model)
        return newModel!
    }
    
    func Update(model: BaseDataModel) -> CrudResult {
        let result = db?.update(model)
        return result == 0 ? .Failed : .Success
    }
    
    func Delete(model: BaseDataModel) -> CrudResult {
        let result = db?.delete(model)
        return result == 0 ? .Failed : .Success
    }
}
