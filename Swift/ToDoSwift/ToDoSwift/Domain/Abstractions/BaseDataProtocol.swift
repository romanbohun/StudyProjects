//
//  BaseDataProtocol.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import Foundation

protocol BaseDataProtocol {
    associatedtype T
    
    var id: T? { get set }
}
