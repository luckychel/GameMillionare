//
//  Result.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import Foundation

class Result: Codable {

    var procent : Double = 0
    var correctAnswerCount: Int = 0
    var moneyEarned: Double = 0.0
    var allAnswerCount: Int = 0
    
    init(procent: Double, correctAnswerCount: Int, moneyEarned: Double, allAnswerCount: Int) {
        self.procent = procent
        self.correctAnswerCount = correctAnswerCount
        self.moneyEarned = moneyEarned
        self.allAnswerCount = allAnswerCount
    }
    
}
