//
//  GuessViewController.swift
//  Mind Flash
//
//  Created by Devan Allara on 3/19/18.
//  Copyright © 2018 Devan Allara. All rights reserved.
//

import UIKit

class GuessViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var addQuestionButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
   var questions = [Question]()
    
    var askedQuestions = [Question]()
    
    var colors = [#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)]
    
    var score = 0
    
    var displayedQuestion: Question?

    override func viewDidLoad() {
        super.viewDidLoad()
        addQuestionButton.layer.cornerRadius = 5
        addQuestionButton.clipsToBounds = true
        resetButton.layer.cornerRadius = 5
        resetButton.clipsToBounds = true
        button1.layer.cornerRadius = 5
        button1.clipsToBounds = true
        button2.layer.cornerRadius = 5
        button2.clipsToBounds = true
        button3.layer.cornerRadius = 5
        button3.clipsToBounds = true
        button4.layer.cornerRadius = 5
        button4.clipsToBounds = true
        loadQuestions()
        generateQuestionText()
        scoreLabel.text = "Score: \(score)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadQuestions() {
        let question1 = Question(questionText: "What color is the sun?", answers: ["Yellow", "Blue", "Green", "Purple"], correctAnswer: 0)
        let question2 = Question(questionText: "Who is the first man on the moon.", answers: ["Yellow", "Blue", "Neil Armstrong", "Purple"], correctAnswer: 2)
        questions.append(question1)
        questions.append(question2)
    }
    
    func generateAnswerButtons(question: Question, colorSelection: [UIColor]) {
       var colorArray = colorSelection
       var questionAnswers = question.answers
        for i in 0...3 {
            let randomAnswer = Int(arc4random_uniform(UInt32(questionAnswers.count)))
            let randomColor = Int(arc4random_uniform(UInt32(colorArray.count)))
            switch i {
            case 0 :
                button1.setTitle(questionAnswers[randomAnswer], for: .normal)
                button1.backgroundColor = colorArray[randomColor]
            case 1:
                button2.setTitle(questionAnswers[randomAnswer], for: .normal)
                button2.backgroundColor = colorArray[randomColor]
            case 2:
                button3.setTitle(questionAnswers[randomAnswer], for: .normal)
                button3.backgroundColor = colorArray[randomColor]
            case 3:
                button4.setTitle(questionAnswers[randomAnswer], for: .normal)
                button4.backgroundColor = colorArray[randomColor]
            default:
                return
            }
            questionAnswers.remove(at: randomAnswer)
            colorArray.remove(at: randomColor)
            
        }
    }
    
    func generateQuestionText() {
        scoreLabel.text = "Score: \(score)"
        let randomQuestionIndex = Int(arc4random_uniform(UInt32(questions.count)))
        let currentQuestion = questions[randomQuestionIndex]
        askedQuestions.append(currentQuestion)
        displayedQuestion = currentQuestion
        questionLabel.text = currentQuestion.questionText
        questions.remove(at: randomQuestionIndex)
        generateAnswerButtons(question: currentQuestion,colorSelection: colors)
    }
    
    func gameOver() {

        let alertView = UIAlertController(title: "Game Over!", message: "Your score was \(score)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Play Again!", style: .default, handler: { action in
          self.questions = self.askedQuestions
          self.askedQuestions = []
          self.generateQuestionText()
        })
        alertView.addAction(okAction)
        
        self.present(alertView, animated: true, completion: nil)
        score = 0
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        let alertView = UIAlertController(title: "Reset", message: "Are you sure you want to reset the game?!", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes!", style: .default, handler: { action in
        self.questions = self.askedQuestions
        self.score = 0
        self.askedQuestions = []
        self.generateQuestionText()
            
        })
        let noAction = UIAlertAction(title: "No!", style: .default, handler: { action in
            self.dismiss(animated: true, completion: nil)
            })
        alertView.addAction(yesAction)
        alertView.addAction(noAction)
        
        self.present(alertView, animated: true, completion: nil)
        
    }
    
    @IBAction func answerButtonTapped(_ sender: Any) {
        let button = sender as! UIButton
        if button.title(for: .normal) == displayedQuestion!.answers[(displayedQuestion!.correctAnswer)] {
            let alertView = UIAlertController(title: "Correct!", message: "You got the answer right, good job!", preferredStyle: .alert)
            score += 1
            let okAction = UIAlertAction(title: "Okay!", style: .default, handler: { action in
                if self.questions.count != 0 {
                self.generateQuestionText()
                } else {
                    self.gameOver()
                }
            })
            alertView.addAction(okAction)
            
            self.present(alertView, animated: true, completion: nil)
        } else {
            let alertView = UIAlertController(title: "Wrong!", message: "You got the answer wrong!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay!", style: .default, handler: { action in
                if self.questions.count != 0 {
                    self.generateQuestionText()
                } else {
                    self.gameOver()
                }
            })
            alertView.addAction(okAction)
            
            self.present(alertView, animated: true, completion: nil)
        }
    }
}
