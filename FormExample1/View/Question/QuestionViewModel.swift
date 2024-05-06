//
//  QuestionViewModel.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import Combine

struct QuestionViewModel {
    // MARK: - Model
    let question: Question

    // MARK: - Emitted events
    let  answerEmittedSource = CurrentValueSubject<Answer, Never>("")

    // MARK: - Injected events
    let injectedErrorToDisplayBus: ErrorToDisplayBus
}
