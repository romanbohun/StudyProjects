//
//  FeaturedTaskManager.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

class FeaturedTaskManager: CommonTaskManager, TaskReadManagerProtocol {
    typealias T = BaseDataModel
    
    override init(taskRepository: BaseRepository) {
        super.init(taskRepository: taskRepository)
    }
    
    func getTasks() -> Array<BaseDataModel> {
        let result = self.taskRepository?.getAll()?.filter({ (BaseDataModel) -> Bool in
            return !(BaseDataModel as! TaskDataModel).done
        })
        
        return result!
    }
}
