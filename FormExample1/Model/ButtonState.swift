//
//  ButtonState.swift
//  FormExample1
//
//  Created by Pierre Simon on 26/04/2024.
//

import Foundation
import SwiftUI

enum ButtonState {
    case formHasError
    case formIsValid
}

extension ButtonState {
    var buttonColor: Color {
        switch self {
        case .formHasError:
            return .orange
        case .formIsValid:
            return .green
        }
    }
}

