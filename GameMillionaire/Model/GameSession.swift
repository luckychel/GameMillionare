//
//  GameSession.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import Foundation

class GameSession {
    
    var allQuestionQuantity: Int = 0
    var correctAnswer: Observable<Int> = Observable<Int>(0)
    var moneyEarned: Observable<Double> = Observable<Double>(0.0)
    
    init(allQuestionQuantity: Int) {
        self.allQuestionQuantity = allQuestionQuantity
    }
    
    func correctAnswerProcent() -> Double {
        return Double(correctAnswer.value * 100 / allQuestionQuantity)
    }
}
