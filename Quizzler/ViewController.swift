//
//  ViewController.swift
//  Quizzler
//
//  Created by Gabriel Perez on 4/13/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var score: Int = 0
    var currentQuestion: Question!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startQuestion()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        nextQuestion()
        updateUI()
    }
    
    func startQuestion() {
        pickedAnswer = false
        questionNumber = 0
        score = 0
        
        currentQuestion = allQuestions.list[questionNumber]
        updateUI()
    }
    
    func nextQuestion() {
        if questionNumber < (allQuestions.list.count - 1) {
            questionNumber += 1
            currentQuestion = allQuestions.list[questionNumber]
        }else {
            let resetAlert = createResetAlert()
            
            present(resetAlert, animated: true, completion: nil)
        }
    }
    
    func checkAnswer() {
        if pickedAnswer == currentQuestion.answer {
            ProgressHUD.showSuccess("Correct!")
            score += 10
        } else {
            ProgressHUD.showError("Wrong!")
        }
    }
    
    func updateUI() {
        questionLabel.text = currentQuestion.questionText
        progressLabel.text = "\(questionNumber + 1) / \(allQuestions.list.count)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber + 1)
        scoreLabel.text = "Score: \(score)"
    }
    
    func createResetAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Awesome", message: "You've finished the all questions, do you want to start over?", preferredStyle: .alert)
        
        let resetAction = UIAlertAction(title: "Reset", style: .default, handler: { (UIAlertAction) in
            self.startQuestion()
        })
        
        alert.addAction(resetAction)
        
        return alert
    }
    
}
