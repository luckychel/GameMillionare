//
//  GameCaretaker.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import Foundation
import UIKit

class GameCaretaker {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let gameRecordsKey = "gameRecords"
    private let gameQuestionShowStrategyKey = "gameQuestionShowStrategy"
    
    var results : [Result]?
    var questions: [Question]?
    
    func saveGame(_ results: [Result])  {
    
        do {
            let data = try encoder.encode(results)
            UserDefaults.standard.set(data, forKey: gameRecordsKey)
        } catch {
            print(error)
        }
    }

    func loadGame() -> [Result] {
        
        guard let data: Data = UserDefaults.standard.data(forKey: gameRecordsKey) else {
            return []
        }
        do {
            return try decoder.decode([Result].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
    
    func saveQuestionShowStrategy(_ questionShow: QuestionShow) {
        UserDefaults.standard.set(questionShow.rawValue, forKey: gameQuestionShowStrategyKey)
    }
    
    func loadQuestionShowStrategy() -> QuestionShow {
        guard let data: String = UserDefaults.standard.string(forKey: gameQuestionShowStrategyKey) else {
            return .consistently
        }
        return QuestionShow(rawValue: data)!
    }
}
