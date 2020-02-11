//
//  CommonTaskManager.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

class CommonTaskManager: TaskManagerProtocol {
    typealias T = BaseDataModel
    
    var taskRepository: BaseRepository?
    
    init(taskRepository: BaseRepository) {
        self.taskRepository = taskRepository
    }
    
    func create(task: BaseDataModel) -> BaseDataModel {
        let model = self.taskRepository?.Add(model: task)
        return model!
    }
    
    func update(task: BaseDataModel) {
        let result = self.taskRepository?.Update(model: task)
        
        if result == CrudResult.Failed {
            //todo throw exception
        }
    }
    
    func delete(task: BaseDataModel) {
        let result = self.taskRepository?.Delete(model: task)
        
        if result == CrudResult.Failed {
            //todo throw exception
        }
    }
    
    
}
