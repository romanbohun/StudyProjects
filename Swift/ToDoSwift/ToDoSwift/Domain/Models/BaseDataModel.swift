//
//  BaseDataModel.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

class BaseDataModel: NSObject, BaseDataProtocol {
    typealias T = String
    
    var id: String?
    
    func updateWith(model: BaseDataModel) {
        
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        
        if let object = object as? BaseDataModel {
            return id == object.id
        } else {
            return false
        }
    }

    override var hash: Int {
        return id.hashValue
    }
    
}
