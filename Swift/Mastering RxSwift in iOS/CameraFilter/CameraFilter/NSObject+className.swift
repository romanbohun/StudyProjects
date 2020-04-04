//
//  NSObject+className.swift
//  CameraFilter
//
//  Created by Roman Bogun on 23.03.2020.
//  Copyright © 2020 Roman Bohun. All rights reserved.
//

import Foundation

extension NSObject {
    
    open class var className: String {
        return String(describing: self)
    }
    
    open var className: String {
        return String(describing: type(of: self))
    }
    
}
