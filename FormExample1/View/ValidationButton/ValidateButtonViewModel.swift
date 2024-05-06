//
//  ValidateButtonViewModel.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import Combine

struct ValidateButtonViewModel {
    let requestValidationEmittedSource = CurrentValueSubject<RequestValidationEvent, Never>(.initial)
    let injectedButtonStateBus: ButtonStateBus
}
