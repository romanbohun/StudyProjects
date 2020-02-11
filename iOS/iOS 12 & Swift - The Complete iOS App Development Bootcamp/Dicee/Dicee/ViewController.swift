//
//  ViewController.swift
//  Dicee
//
//  Created by Roman Bogun on 7/3/19.
//  Copyright © 2019 Roman Bohun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dice1ImageView: UIImageView!
    @IBOutlet weak var dice2ImageView: UIImageView!
    
    var randomDiceIndex1: Int = 0
    var randomDiceIndex2: Int = 0
    var diceImageNames: Array = ["dice1", "dice2", "dice3", "dice4", "dice4", "dice5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initDices()
    }

    @IBAction func rollButtonPressed(_ sender: Any) {
        initDices()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == UIEvent.EventSubtype.motionShake {
            initDices()
        }
    }
    
    private func initDices() {
        randomizeDices()
        updateDiceImages()
    }
    
    private func randomizeDices() {
        randomDiceIndex1 = getRandomNumber()
        randomDiceIndex2 = getRandomNumber()
    }
    
    private func getRandomNumber() -> Int {
        return Int.random(in: 0...5)
    }
    
    private func updateDiceImages() {
        dice1ImageView.image = UIImage(named: diceImageNames[randomDiceIndex1])
        dice2ImageView.image = UIImage(named: diceImageNames[randomDiceIndex2])
    }
}

