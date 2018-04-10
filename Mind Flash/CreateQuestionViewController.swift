//
//  CreateQuestionViewController.swift
//  Mind Flash
//
//  Created by Devan Allara on 3/19/18.
//  Copyright © 2018 Devan Allara. All rights reserved.

import UIKit

class CreateQuestionViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answer1TextField: UITextField!
    @IBOutlet weak var answer2TextField: UITextField!
    @IBOutlet weak var answer3TextField: UITextField!
    @IBOutlet weak var answer4TextField: UITextField!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    var newQuestion: Question!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func addButtonTapped(_ sender: Any) {
       newQuestion = Question(questionText: questionTextField.text!
            , answers: [answer1TextField.text!, answer2TextField.text!, answer3TextField.text!, answer4TextField.text!], correctAnswer: segmentedController.selectedSegmentIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "guessScreen") {
            let vc = segue.destination as! GuessViewController
            vc.questions.append(newQuestion)
        }
    }
    
}
