//
//  Result.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import Foundation

class Result: Codable {

    var procent : Double?
    
    var correctAnswerCount: Int?
    
    init(procent: Double? = nil, correctAnswerCount: Int? = nil) {
        self.procent = procent
        self.correctAnswerCount = correctAnswerCount
    }
    
}
