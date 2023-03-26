//
//  GameSession.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import Foundation

class GameSession {
    var correctAnswer: Int
    var questionQuantity: Int
    
    init(correctAnswer: Int = 0, questionQuantity: Int = 0) {
        self.correctAnswer = correctAnswer
        self.questionQuantity = questionQuantity
    }
}
