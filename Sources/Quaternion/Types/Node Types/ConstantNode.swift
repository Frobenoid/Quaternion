//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

import Foundation

struct ConstantNode: NodeType {
    func execute(params p: inout ExecutionParameters) throws {
    }

    func declareNode(params b: inout ParametersBuilder) {
        b.addOutput(
            named: "Value",
            ofType: NumericSocket(defaultValue: SocketValueType.numeric(1.0))
        )
    }
}
