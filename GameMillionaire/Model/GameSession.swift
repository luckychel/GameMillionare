//
//  GameSession.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import Foundation

class GameSession {
    
    var correctAnswer: Int = 0
    var questionQuantity: Int = 0
    var moneyEarned: Double = 0.0
    
    init(correctAnswer: Int, questionQuantity: Int, moneyEarned: Double) {
        self.correctAnswer = correctAnswer
        self.questionQuantity = questionQuantity
        self.moneyEarned = moneyEarned
    }
    
    func correctAnswerProcent() -> Double {
        return Double(correctAnswer * 100 / questionQuantity)
    }
}
