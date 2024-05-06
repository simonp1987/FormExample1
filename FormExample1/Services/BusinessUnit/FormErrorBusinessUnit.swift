//
//  FormErrorBusinessUnit.swift
//  FormExample1
//
//  Created by Pierre Simon on 26/04/2024.
//

import Foundation

struct FormErrorBusinessUnit {
    private let question: Question

    init(question: Question) {
        self.question = question
    }

    func transform(answerBus: AnswerBus) -> QuestionErrorBus {
        return answerBus
            .compactMap { return self.question.rules.error(for: $0) }
            .share()
            .eraseToAnyPublisher()
    }
}
