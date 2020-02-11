//
//  BaseViewController.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initUIPart()
    }
    
    public func getTitleName() -> String {
        return ""
    }
    
    public func initUIPart() -> Void {
        self.view.backgroundColor = UIColor.white
        self.title = getTitleName()
    }
    
    public func resetRightBarButtons() {
        self.navigationItem.rightBarButtonItems?.removeAll()
        self.navigationItem.rightBarButtonItem = nil
    }
}
