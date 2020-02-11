//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Roman Bogun on 28.11.2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var bmi: Bmi?
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let bmi = bmi else { fatalError() }
        
        resultLabel.text = String(format: "%.1f", bmi.bmi)
        adviceLabel.text = bmi.advice
        view.backgroundColor = bmi.color
    }
    
    @IBAction func recalculateAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
