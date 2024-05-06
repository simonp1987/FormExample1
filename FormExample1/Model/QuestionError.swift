//
//  QuestionError.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import Foundation

enum QuestionError: Equatable {
    case noError
    case questionError(errorMessage: String)
}

extension QuestionError {
    var isVisible: Bool {
        switch self {
        case .noError:
            return false
        case .questionError:
            return true
        }
    }

    var errorMessage: String {
        switch self {
        case .noError:
            return ""
        case .questionError(let errorMessage):
            return errorMessage
        }
    }
}
