//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

import Foundation

class ConstantNode: NodeType {
    var metadata: any NodeTypeMetadata = TypeMetadata(
        name: "Constant Node",
        description: "Returns a constant numeric value",
        tags: ["Constant", "Numeric", "Math"]
    )

    func execute(params p: inout ExecutionParameters) throws {
    }

    func declareNode(params b: inout ParametersBuilder) {
        b.addOutput(
            named: "Value",
            ofType: NumericSocket(defaultValue: SocketValueType.numeric(1.0))
        )
    }
}
