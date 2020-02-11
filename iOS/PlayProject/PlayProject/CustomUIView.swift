//
//  CustomUIView.swift
//  PlayProject
//
//  Created by Roman Bogun on 7/23/19.
//  Copyright © 2019 Roman Bohun. All rights reserved.
//

import UIKit

@IBDesignable class CustomUIView: UIView {
    @IBInspectable var backgrndColor: UIColor = UIColor.black {
        didSet {
            layer.backgroundColor = backgrndColor.cgColor
        }
    }
    @IBInspectable var text: String?
    @IBInspectable var showText: Bool = true
}
