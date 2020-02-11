//
//  BaseTabBarViewController.swift
//  ToDoSwift
//
//  Created by Roman Bogun on 3/14/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "ToDoSwift"
        
//        viewControllers = initTabBar().map { (controller: UIViewController) in
//           UINavigationController(rootViewController: controller)
//        }
        
        viewControllers = initTabBar()
    }
    
    @objc func gotoAddNewPage(_ sender:UIBarButtonItem!){
        
    }
    
    private func initTabBar() -> Array<UIViewController> {
        var result: Array<UIViewController> = Array<UIViewController>()
        
        result.append(UINavigationController(rootViewController: initFirstVC()))
        result.append(UINavigationController(rootViewController: initSecondVC()))
        
        return result
    }

    private func initFirstVC() -> UIViewController {
        let featuredVc = FeaturedViewController(nibName: String(describing: type(of: FeaturedViewController.self())), bundle: nil)
        featuredVc.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        featuredVc.tabBarItem.title = featuredVc.getTitleName()
        
        return featuredVc
    }
    
    private func initSecondVC() -> UIViewController {
        let historyVc = HistoryViewController(nibName: String(describing: type(of: HistoryViewController.self())), bundle: nil)
        historyVc.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        historyVc.tabBarItem.title = historyVc.getTitleName()
        
        return historyVc
    }
}
