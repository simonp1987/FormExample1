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
    func error(for answer: Answer) -> String? {
        switch self {
        case .regex(let regex, let errorMessage):
            if answer.isEmpty { return nil }
            return answer.matches(regex) ? nil : errorMessage
        case .isCompulsory(let errorMessage):
            return answer.isEmpty ? errorMessage : nil
        }
    }
}

extension Array where Element == QuestionRule {
    func error(for answer: Answer) -> QuestionError {
        return self.reduce(QuestionError.noError) { currentError, rule in
            switch currentError {
            case .noError:
                guard let errorMessage = rule.error(for: answer) else {
                    return .noError
                }
                return  .questionError(
                    errorMessage: errorMessage
                )
            case .questionError: return currentError
            }
        }
    }
}
