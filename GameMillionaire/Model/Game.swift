//
//  Game.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import Foundation

class Game {
    
    static let shared = Game()
    
    private let resultsCaretaker = GameCaretaker()
    
    private (set) var questionShow: QuestionShow {
        didSet {
            resultsCaretaker.saveQuestionShowStrategy(self.questionShow)
        }
    }
    
    private (set) var results : [Result] {
        didSet {
            resultsCaretaker.saveGame(self.results)
        }
    }
    
    private init(){
        self.results = self.resultsCaretaker.loadGame()
        self.questionShow = self.resultsCaretaker.loadQuestionShowStrategy()
    }
    
    var session: GameSession?
  
    func addResult(_ result: Result) {
        results.append(result)
    }
   
    func setQuestionShow(_ questionShow: QuestionShow) {
        self.questionShow = questionShow
    }
}
