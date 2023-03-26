//
//  Game.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import Foundation

class Game {
    
    private let resultsCaretaker = GameCaretaker()
    
    var session: GameSession?
    
    func corAnswerProcent (correctAnswerCount: Int, totalQuestionCount: Int) -> Double {
        
        return Double(correctAnswerCount * 100 / totalQuestionCount)
        
    }
    
   var results : [Result] {
        didSet {
            resultsCaretaker.saveGame(self.results)
        }
    }
    
    static let shared = Game()
    
    private init(){
        self.results = self.resultsCaretaker.loadGame()
    }
}
