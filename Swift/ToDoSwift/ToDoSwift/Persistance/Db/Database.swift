//
//  Database.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

class Database {
    private var taskTable: Array<BaseDataModel>
    
    static let shared = Database()
    
    private init() {
        taskTable = Array<BaseDataModel>()
        
        var task1 = TaskDataModel()
        task1.name = "Task 1"
        task1.descr = "Super task 1"
        
        taskTable.append(task1)
        
        var task2 = TaskDataModel()
        task2.name = "Task 2"
        task2.descr = "Super task 2"
        taskTable.append(task2)
    }
    
    func getTaskTable() -> Array<BaseDataModel> {
        return self.taskTable;
    }
    
    func add(_ model: BaseDataModel) -> BaseDataModel {
        self.taskTable.append(model)
        model.id = UUID().uuidString
        
        return model
    }
    
    func update(_ model: BaseDataModel) -> Int {
        
        let data = self.taskTable.first { (BaseDataModel) -> Bool in
            return BaseDataModel.isEqual(model)
        }
        
        if data == nil {
            return 0
        } else {
            data?.updateWith(model: model)
        }
        
        return 1
    }
    
    func delete(_ model: BaseDataModel) -> Int {
        
        let index = self.taskTable.firstIndex(of: model)
        
        if index == nil {
            return 0
        } else {
            self.taskTable.remove(at: index!)
        }
        
        return 1
    }
}
