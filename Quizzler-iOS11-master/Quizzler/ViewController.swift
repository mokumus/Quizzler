//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
    let allQuestions = QuestionBank()
	var pickedAnswer : Bool = false
	var questionNumber : Int = 0
	var score : Int = 0
	
	
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		nextQuestion()
		
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
		if sender.tag == 1{
			pickedAnswer = true
		}
		else if sender.tag == 2{
			pickedAnswer = false
		}
		
		checkAnswer()
		questionNumber += 1
		
		nextQuestion()
    }
    
    
    func updateUI() {
		scoreLabel.text = "Score: \(score)"
		progressLabel.text = "\(questionNumber + 1) / \(allQuestions.list.count)"
		progressBar.frame.size.width = ((view).frame.size.width / 13 ) * CGFloat(questionNumber+1)
    }
    

	func nextQuestion() {
		if questionNumber < allQuestions.list.count{
			questionLabel.text = allQuestions.list[questionNumber].questionText
			updateUI()
		}
		else{
			let alert = UIAlertController(title: "Game over", message: "Would you like to restart?", preferredStyle: .alert)
			
			let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
				self.startOver()
			})
			
			alert.addAction(restartAction)
			present(alert, animated: true, completion: nil)
		}
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
		
		if correctAnswer == pickedAnswer{
			ProgressHUD.showSuccess("Correct!")
			score += 100
			
		}
		else{
			ProgressHUD.showError("Wrong!")
			score -= 50
		}
    }
    
    
    func startOver() {
		score = 0
       	questionNumber = 0
		nextQuestion()
    }
	
}
