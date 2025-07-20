//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 20/07/25.
//

import Testing

@testable import Quaternion

// 2 + 2 = 4
@Test func defaultValuesTest() async throws {
    var tree = Tree(name: "2+2=4")
    // TODO: Notice that name is irrelevant for nodes.
    let lhs = tree.addNode(named: "Constant", ofType: ConstantNode())
    let rhs = tree.addNode(named: "Constant", ofType: ConstantNode())

    let socketLHS = try tree.findNodeById(id: lhs).getOutputSocket(
        named: "Value"
    ).id
    let socketRHS = try tree.findNodeById(id: rhs).getOutputSocket(
        named: "Value"
    ).id

    // MARK: - Set default values
    try tree.setSocketDefaultValue(
        forNode: lhs,
        atSocket: socketLHS,
        to: .numeric(2)
    )
    try tree.setSocketDefaultValue(
        forNode: rhs,
        atSocket: socketRHS,
        to: .numeric(2)
    )

    let op = tree.addNode(named: "Sum", ofType: MathNode())

    try tree.connect(from: lhs, atSocket: "Value", to: op, atSocket: "LHS")
    try tree.connect(from: rhs, atSocket: "Value", to: op, atSocket: "RHS")

    try tree.execute()

    let opNode = try tree.findNodeById(id: op)
    let result = try opNode.getOutputSocket(named: "Result").type.readValue()

    #expect(result == .numeric(4.0))

}

@Test func setCurrentValueTest() async throws {
    var tree = Tree(name: "2+2=4")
    // TODO: Notice that name is irrelevant for nodes.
    let lhs = tree.addNode(named: "Constant", ofType: ConstantNode())
    let rhs = tree.addNode(named: "Constant", ofType: ConstantNode())

    let socketLHS = try tree.findNodeById(id: lhs).getOutputSocket(
        named: "Value"
    ).id
    let socketRHS = try tree.findNodeById(id: rhs).getOutputSocket(
        named: "Value"
    ).id

    // MARK: - Set actual values
    try tree.setSocketValue(
        forNode: lhs,
        atSocket: socketLHS,
        to: .numeric(2)
    )
    try tree.setSocketValue(
        forNode: rhs,
        atSocket: socketRHS,
        to: .numeric(2)
    )

    let op = tree.addNode(named: "Sum", ofType: MathNode())

    try tree.connect(from: lhs, atSocket: "Value", to: op, atSocket: "LHS")
    try tree.connect(from: rhs, atSocket: "Value", to: op, atSocket: "RHS")

    try tree.execute()

    let opNode = try tree.findNodeById(id: op)
    let result = try opNode.getOutputSocket(named: "Result").type.readValue()

    #expect(result == .numeric(4.0))
}

@Test func disconnectionTest() async throws {
    var tree = Tree(name: "2+1=3")
    // TODO: Notice that name is irrelevant for nodes.
    let lhs = tree.addNode(named: "Constant", ofType: ConstantNode())
    let rhs = tree.addNode(named: "Constant", ofType: ConstantNode())

    let socketLHS = try tree.findNodeById(id: lhs).getOutputSocket(
        named: "Value"
    ).id
    let socketRHS = try tree.findNodeById(id: rhs).getOutputSocket(
        named: "Value"
    ).id

    // MARK: - Set actual values
    try tree.setSocketValue(
        forNode: lhs,
        atSocket: socketLHS,
        to: .numeric(2)
    )
    try tree.setSocketValue(
        forNode: rhs,
        atSocket: socketRHS,
        to: .numeric(2)
    )

    let op = tree.addNode(named: "Sum", ofType: MathNode())

    try tree.connect(from: lhs, atSocket: "Value", to: op, atSocket: "LHS")
    try tree.connect(from: rhs, atSocket: "Value", to: op, atSocket: "RHS")

    try tree.execute()

    let opNode = try tree.findNodeById(id: op)
    let result = try opNode.getOutputSocket(named: "Result").type.readValue()

    #expect(result == .numeric(4.0))

    let lhs1 = tree.addNode(named: "Constant", ofType: ConstantNode())
    let mathLHS = try tree.findNodeById(id: op).getInputSocket(named: "LHS").id

    try tree.disconnect(node: lhs, outputSocket: socketLHS, fromSocket: mathLHS)

    try tree.connect(from: lhs1, atSocket: "Value", to: op, atSocket: "LHS")
    
    try tree.execute()
    
    let opNode1 = try tree.findNodeById(id: op)
    let result1 = try opNode1.getOutputSocket(named: "Result").type.readValue()
    
    #expect(result1 == .numeric(3.0))
}
