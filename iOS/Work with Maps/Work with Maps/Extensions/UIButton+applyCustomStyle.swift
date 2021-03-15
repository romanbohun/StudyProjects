//
//  UIButton+applyCustomStyle.swift
//  Work with Maps
//
//  Created by Roman Bogun on 15.03.2021.
//

import UIKit

extension UIButton {

    func applyCustomStyle() -> UIButton {
        self.backgroundColor = .white
        self.setTitleColor(.blue, for: .normal)
        return self
    }

}
