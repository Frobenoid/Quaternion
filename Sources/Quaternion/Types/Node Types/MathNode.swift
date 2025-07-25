//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

import Foundation

class MathNode: NodeType {
    var metadata: any NodeTypeMetadata = TypeMetadata(
        name: "Math Node",
        description:
            "This node performs basic arithmetic operations on two numeric inputs.",
        tags: ["Math", "Arithmetic", "Numeric"]
    )

    func execute(params p: inout ExecutionParameters) throws {
        let lhs: Float = try p.getInputValue(named: "LHS")
        let rhs: Float = try p.getInputValue(named: "RHS")

        try p.setOutput(named: "Result", to: .numeric(lhs + rhs))
    }

    func declareNode(params b: inout ParametersBuilder) {
        b.addInput(named: "LHS", ofType: NumericSocket())
        b.addInput(named: "RHS", ofType: NumericSocket())
        b.addOutput(named: "Result", ofType: NumericSocket())
    }
}
