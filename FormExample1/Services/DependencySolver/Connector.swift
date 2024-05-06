//
//  Connector.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import Combine
import Foundation

final class Connector {
    // MARK: Fake View Input for View creation
    private let injectedErrorToDisplaySubject = 
    PassthroughSubject<QuestionError, Never>()
    private(set) lazy var injectedErrorToDisplayBus =
    self.injectedErrorToDisplaySubject
        .eraseToAnyPublisher()

    private let injectedButtonStateSubject =
    PassthroughSubject<ButtonState, Never>()
    private(set) lazy var injectedButtonStateBus =
    self.injectedButtonStateSubject
        .eraseToAnyPublisher()

    // MARK: Utils
    private var subscriptions = Set<AnyCancellable>()

    // MARK: Internal
    func connect(connectableSources: ConnectableSources,
                 errorToDisplayBusinessOutput: ErrorToDisplayBus,
                 buttonStateBusinessOutput: ButtonStateBus) {

        // MARK: - Redirect Business Output in View Input.
        errorToDisplayBusinessOutput
            .receive(on: DispatchQueue.main)
            .sink {
            self.injectedErrorToDisplaySubject.send($0)
        }
        .store(in: &self.subscriptions)

        buttonStateBusinessOutput
            .receive(on: DispatchQueue.main)
            .sink {
            self.injectedButtonStateSubject.send($0)
        }
        .store(in: &self.subscriptions)

        // MARK: - Connect sources of events:
        // - after the Business Output has been redirected
        // - and after the View has opened its pipeline (onReceive/sink).
        connectableSources.answerConnectableSource
            .connect()
            .store(in: &self.subscriptions)

        connectableSources.requestValidationConnectableSource
            .connect()
            .store(in: &self.subscriptions)
    }
}
