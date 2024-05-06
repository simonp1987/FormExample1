//
//  QuestionView.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import SwiftUI

struct QuestionView: View {
    // MARK: - Private Properties
    private let viewModel: QuestionViewModel

    // MARK: - Private State
    @State private var answer: String = ""
    @State private var error: QuestionError = .noError

    // MARK: - Init
    init(viewModel: QuestionViewModel) {
        self.viewModel = viewModel
    }

    // MARK: - Body
    var body: some View {
        VStack {
            TextField(self.viewModel.question.questionLabel,
                      text: self.$answer)
                .onChange(of: self.answer) {
                    self.viewModel.answerEmittedSource.send(self.answer)
                }
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
            Text(self.error.errorMessage)
                .onReceive(self.viewModel.injectedErrorToDisplayBus, 
                           perform: { newError in
                    guard self.error != newError else { return }
                    self.error = newError
                })
                .foregroundStyle(.red)
                .opacity(self.error.isVisible ? 1 : 0)
        }
    }
}

