//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    private let questionBank = QuestionBank()
    private var currentIndex : Int = 0
    private var questionNumber : Int = 1
    private var currentQuestion : Question?
    private var pickedAnswer : Bool = false;
    private var amountIOfCorrectAnswers : Int = 0;
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        pickedAnswer = sender.tag == 1
        
        checkAnswer()
        
        questionNumber += 1
        
        nextQuestion()
        updateUI()
    }
    
    
    func updateUI() {
        questionLabel.text = currentQuestion?.questionText
        scoreLabel.text = "Score: \(amountIOfCorrectAnswers)"
        progressLabel.text = "\(questionNumber)/\(questionBank.list.count)"
        
        var frame = progressBar.frame
        let viewFrame = view.frame
        frame.size.width = (viewFrame.size.width / CGFloat(questionBank.list.count)) * CGFloat(questionNumber)
        progressBar.frame = frame
    }
    
    
    func nextQuestion() {
        
        if currentIndex == questionBank.list.count - 1 {
            let alert = UIAlertController(title: "Quiz is finished", message: "Would you like to start over?", preferredStyle: .alert)
            let actionRestart = UIAlertAction(title: "Restart", style: .default) { (alert) in
                self.startOver()
                
                self.nextQuestion()
                self.updateUI()
            }

            alert.addAction(actionRestart)
            
            self.present(alert, animated: true, completion: nil)
        } else {
            currentQuestion = questionBank.list[currentIndex]
            currentIndex += 1
        }
    }
    

    func checkAnswer() {
        if (pickedAnswer == currentQuestion?.answer) {
            ProgressHUD.showSuccess("Correct")
            
            amountIOfCorrectAnswers += 1
        } else {
            ProgressHUD.showError("Wrong!")
        }
    }
    
    
    func startOver() {
        currentIndex = 0
        questionNumber = 1
        currentQuestion = nil
        pickedAnswer = false
        amountIOfCorrectAnswers = 0
    }
    

    
}
