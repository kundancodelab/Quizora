//
//  QuestionModel.swift
//  QuizApp
//
//  Created by User on 07/04/25.
//

import Foundation

struct QuestionModel: Codable {
    let question: String
    let options: [String]
    let answer: String
    let explanation: String
}

// MARK: - Backward Compatibility
typealias questionModel = QuestionModel
