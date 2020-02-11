//
//  TaskDataModel.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

class TaskDataModel: BaseDataModel {
    var name: String?
    var descr: String?
    var favorite: Bool = false
    var done: Bool = false
}
