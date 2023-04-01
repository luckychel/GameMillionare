//
//  QuestionShow.swift
//  GameMillionaire
//
//  Created by Александр Кукоба on 01.04.2023.
//

import Foundation

enum QuestionShow: CaseIterable {
    case consistently, chaotic
}
extension CaseIterable where Self: Equatable {
    var index: Self.AllCases.Index? {
        return Self.allCases.firstIndex { self == $0 }
    }
}
