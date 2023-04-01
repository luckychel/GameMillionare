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
    var session: GameSession?
    
    private init(){
        self.results = self.resultsCaretaker.loadGame()
        self.questionShow = self.resultsCaretaker.loadQuestionShowStrategy()
        self.questions = self.resultsCaretaker.loadQuestions()
    }
    
    private (set) var results : [Result] {
        didSet {
            resultsCaretaker.saveGame(self.results)
        }
    }
    
    func addResult(_ result: Result) {
        results.append(result)
    }
    
    func clearResults() -> [Result] {
        results = []
        return self.results
    }
    
    private (set) var questionShow: QuestionShow {
        didSet {
            resultsCaretaker.saveQuestionShowStrategy(self.questionShow)
        }
    }
    
    func setQuestionShow(_ questionShow: QuestionShow) {
        self.questionShow = questionShow
    }
    
    private (set) var questions : [Question] {
        didSet {
            resultsCaretaker.saveQuestions(self.questions)
        }
    }
    
    func addQuestion(_ result: Question) {
        questions.append(result)
    }
}
