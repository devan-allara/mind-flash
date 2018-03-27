//
//  Guess.swift
//  Mind Flash
//
//  Created by Devan Allara on 3/22/18.
//  Copyright © 2018 Devan Allara. All rights reserved.
//

import Foundation

class Question {
    
    var questionText: String
    var answers: [String]
    var correctAnswer: Int
    
    init(questionText: String, answers: [String], correctAnswer: Int) {
        self.questionText = questionText
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
}




