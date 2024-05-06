//
//  ButtonStateBusinessUnit.swift
//  FormExample1
//
//  Created by Pierre Simon on 26/04/2024.
//

import Foundation

struct ButtonStateBusinessUnit {
    func transform(questionErrorBus: QuestionErrorBus) -> ButtonStateBus {
        return questionErrorBus.map({ error in
            switch error {
            case .noError: return .formIsValid
            case .questionError: return .formHasError
            }
        })
        .removeDuplicates()
        .eraseToAnyPublisher()
    }
}
