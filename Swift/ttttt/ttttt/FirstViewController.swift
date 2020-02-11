//
//  FirstViewController.swift
//  ttttt
//
//  Created by Roman Bogun on 3/16/19.
//  Copyright © 2019 Roman Bogun. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btn.addTarget(self, action: #selector(someMethod), for: .touchUpInside)
    }

    @objc func someMethod(){
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.red
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

