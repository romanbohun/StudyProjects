//
//  UIImage+imageForIcon.swift
//  Cloudy
//
//  Created by Roman Bogun on 23.02.2020.
//  Copyright © 2020 Cocoacasts. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageForIconName(withName name: String) -> UIImage? {
        switch name {
        case "clear-day", "clear-night", "rain", "snow", "sleet":
            return UIImage(named: name)
        case "wind", "cloudy", "partly-cloudy-day", "partly-cloudy-night":
            return UIImage(named: "cloudy")
        default:
            return UIImage(named: "clear-day")
        }
    }
    
}
