//
//  Definitions.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import Combine

typealias Answer = String

typealias AnswerBus = AnyPublisher<Answer, Never>
typealias RequestValidationBus = AnyPublisher<RequestValidationEvent, Never>

typealias QuestionErrorBus = AnyPublisher<QuestionError, Never>

typealias ErrorToDisplayBus = AnyPublisher<QuestionError, Never>
typealias ButtonStateBus = AnyPublisher<ButtonState, Never>

