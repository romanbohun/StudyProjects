//
//  ViewController.swift
//  8Ball
//
//  Created by Roman Bogun on 7/3/19.
//  Copyright © 2019 Roman Bohun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ballImageView: UIImageView!
    
    var balls: Array = ["ball1", "ball2", "ball3", "ball4", "ball4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getTheAnswer()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if (motion == UIEvent.EventSubtype.motionShake) {
            getTheAnswer()
        }
    }
    @IBAction func askButtonTapped(_ sender: Any) {
        getTheAnswer()
    }
    
    private func getTheAnswer() {
        
        let number = getRandomNumber()
        updateImageWithNumber(number)
    }
    
    private func getRandomNumber() -> Int {
        return Int.random(in: 0...4)
    }
    
    private func updateImageWithNumber(_ number: Int) {
        ballImageView.image = UIImage(named: balls[number])
    }
}

