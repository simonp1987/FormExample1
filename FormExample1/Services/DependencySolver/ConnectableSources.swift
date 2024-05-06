//
//  ConnectableSources.swift
//  FormExample1
//
//  Created by Pierre Simon on 24/04/2024.
//

import Combine

struct ConnectableSources {
    let answerConnectableSource: Publishers.MakeConnectable<AnswerBus>
    let requestValidationConnectableSource: Publishers.MakeConnectable<RequestValidationBus>
}
