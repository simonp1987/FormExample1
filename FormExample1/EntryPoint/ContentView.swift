//
//  ContentView.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import SwiftUI

// MARK: - Model creation
let question = Question(
    questionLabel: "first question",
    rules: [
        .isCompulsory(errorMessage: "the question is compulsory"),
        .regex(regex: "^[0-9]*$", errorMessage: "the answer must be a number")
    ]
)

struct ContentView: View {
    private let solver: Solver

    init() {
        // MARK: - Solver creation
        self.solver = Solver(question: question)

    }

    var body: some View {
        VStack {
            Spacer()
            QuestionView(viewModel: self.solver.questionViewModel)
            ValidateButton(viewModel: self.solver.validateButtonViewModel)
            Spacer()
        }
        .padding()
        .onAppear(perform: {
            self.solver.connect()
        })
    }
}

#Preview {
    ContentView()
}
