//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {

    var calculatorBrain = CalculatorBrain()
    
    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var weightValueLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func heightSliderAction(_ sender: UISlider) {
        heightValueLabel.text = String(format: "%.2fm", sender.value)
    }
    
    @IBAction func weightSliderAction(_ sender: UISlider) {
        weightValueLabel.text = String(format: "%.0fKg", sender.value)
    }
    
    @IBAction func calculateAction(_ sender: UIButton) {
        calculatorBrain.calculateBMI(height: heightSlider.value, weight: weightSlider.value)
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult",
            let vc = segue.destination as? ResultViewController {
            vc.bmi = calculatorBrain.bmi
        }
    }
    
}

