//
//  Question.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 26.03.2023.
//

import Foundation

struct Question: Codable {
    let question: String
    var answers: [String]
    let rightAnswer: Int
    let cash: Double
}
