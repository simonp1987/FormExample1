//
//  ErrorToDisplayBusinessUnit.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import Combine


struct ErrorToDisplayBusinessUnit {
    func transform(questionErrorBus: QuestionErrorBus,
                   requestValidationBus: RequestValidationBus) -> ErrorToDisplayBus {
        return questionErrorBus
            .combineLatest(requestValidationBus)
            .map { error, requestValidation in
                switch requestValidation {
                case .initial: return .noError
                case .requestValidation: return error
                }
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
}

