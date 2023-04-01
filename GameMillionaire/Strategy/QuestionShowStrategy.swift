//
//  QuestionShowStrategy.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 01.04.2023.
//

import Foundation

protocol QuestionShowStrategy {
    func mixQuestion(_ questionShow: QuestionShow) -> [Question]
}

class ConsistentlyQuestionsStrategy: QuestionShowStrategy {
    func mixQuestion(_ questionShow: QuestionShow) -> [Question] {
        return QuestionsData().questions
    }
}

class ChaoticQuestionsStrategy: QuestionShowStrategy {
    func mixQuestion(_ questionShow: QuestionShow) -> [Question] {
        return QuestionsData().questions.shuffled()
    }
}
