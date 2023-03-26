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
    private let key = "gameRecords"

    var results : [Result]?

    func saveGame(_ results: [Result])  {
    
        do {
            let data = try encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    func loadGame() -> [Result] {
        
        guard let data: Data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try decoder.decode([Result].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
