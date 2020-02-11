//
//  FeaturedViewModelFactory.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/16/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

class FeaturedViewModelFactory: ViewModelFactoryProtocol {
    typealias T = FeaturedViewModel
    
    func getInstance() -> FeaturedViewModel {
        
        let viewModel = FeaturedViewModel(featuredManager: FeaturedTaskManager(taskRepository: BaseRepository(db: Database.shared)))
        viewModel.initWithTasks()
        
        return viewModel
    }
}
