//
//  QuestionRule.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import Foundation

enum QuestionRule {
    case regex(regex: String, errorMessage: String)
    case isCompulsory(errorMessage: String)
}

extension QuestionRule {
    func error(for answer: Answer) -> QuestionError {
        switch self {
        case .regex(let regex, let errorMessage):
            if answer.isEmpty { return .noError }
            return answer.matches(regex) ? .noError : .questionError(errorMessage: errorMessage)
        case .isCompulsory(let errorMessage):
            return answer.isEmpty ? .questionError(errorMessage: errorMessage) : .noError
        }
    }
}

extension Array where Element == QuestionRule {
    func error(for answer: Answer) -> QuestionError {
        let firstBrokenRule = self.first { $0.error(for: answer) != .noError }
        return firstBrokenRule?.error(for: answer) ?? .noError
    }
}
