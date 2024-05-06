//
//  Solver.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import Foundation

import Combine

final class Solver {
    // MARK: - Connector
    private let connector = Connector()

    // MARK: - Model
    private let question: Question

    // MARK: - Service
    private let formErrorBU: FormErrorBusinessUnit
    private let buttonStateBU: ButtonStateBusinessUnit
    private let errorToDisplayBU: ErrorToDisplayBusinessUnit

    // MARK: - View Models
    private(set) lazy var questionViewModel = QuestionViewModel(
        question: self.question,
        injectedErrorToDisplayBus: self.connector.injectedErrorToDisplayBus
    )

    private(set) lazy var validateButtonViewModel = ValidateButtonViewModel(
        injectedButtonStateBus: self.connector.injectedButtonStateBus
    )

    // MARK: - Init
    init(question: Question) {
        self.question = question

        self.formErrorBU = FormErrorBusinessUnit(question: question)
        self.buttonStateBU = ButtonStateBusinessUnit()
        self.errorToDisplayBU = ErrorToDisplayBusinessUnit()
    }
}

// MARK: Private functions
extension Solver {
    func connect() {
        // MARK: - Get the Sources of Events in Views
        let answerBus = self.questionViewModel.answerEmittedSource
            .eraseToAnyPublisher().makeConnectable()

        let requestValidationBus = self.validateButtonViewModel.requestValidationEmittedSource
            .eraseToAnyPublisher().makeConnectable()

        // MARK: - Transform Events in the Business Unit
        let formErrorIntermediateBus = self.formErrorBU.transform(
            answerBus: answerBus.eraseToAnyPublisher()
        )

        let buttonStateBusinessOutput = self.buttonStateBU.transform(
            questionErrorBus: formErrorIntermediateBus
        )

        let errorToDisplayBusinessOutput = self.errorToDisplayBU.transform(
            questionErrorBus: formErrorIntermediateBus,
            requestValidationBus: requestValidationBus.eraseToAnyPublisher()
        )

        // MARK: - Bundle of Connectable Sources
        let connectableSource = ConnectableSources(
            answerConnectableSource: answerBus,
            requestValidationConnectableSource: requestValidationBus
        )

        // MARK: - Send the Sources and the Business Output in the Connector
        self.connector.connect(
            connectableSources: connectableSource,
            errorToDisplayBusinessOutput: errorToDisplayBusinessOutput,
            buttonStateBusinessOutput: buttonStateBusinessOutput
        )
    }
}
