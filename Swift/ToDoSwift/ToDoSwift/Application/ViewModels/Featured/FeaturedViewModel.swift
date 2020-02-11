//
//  FeaturedViewModel.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/16/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

class FeaturedViewModel: BaseViewModel {
    
    var tasks: Array<TaskDataModel> = Array<TaskDataModel>()
    
    private let manager: FeaturedTaskManager?
    
    init(featuredManager: FeaturedTaskManager) {
        self.manager = featuredManager
    }
    
    public func initWithTasks() {
        tasks.removeAll()
        
//        let t2 = manager?.getTasks().map({ (BaseDataModel) -> TaskDataModel in
//            return BaseDataModel as! TaskDataModel
//        })
        
        let t = manager?.getTasks()
        tasks.append(contentsOf: t as! [TaskDataModel])
    }
    
    public func deleteTask(task: TaskDataModel) {
        manager?.delete(task: task)
        initWithTasks()
    }
}
