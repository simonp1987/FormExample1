//
//  ValidateButton.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import SwiftUI

struct ValidateButton: View {
    // MARK: - Private Properties
    private let viewModel: ValidateButtonViewModel
    @State private var buttonState: ButtonState = .formHasError

    // MARK: - Init
    init(viewModel: ValidateButtonViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body
    var body: some View {
        Button("Validate") {
            self.viewModel.requestValidationEmittedSource
                .send(.requestValidation)
        }
        .onReceive(self.viewModel.injectedButtonStateBus, 
                   perform: { newButtonState in
            guard self.buttonState != newButtonState else { return }
            self.buttonState = newButtonState
        })
        .foregroundColor(self.buttonState.buttonColor)
    }
}
