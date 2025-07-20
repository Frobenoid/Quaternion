import Testing

@testable import Quaternion

@Test func onePlusOneTest() async throws {
    var tree = Tree(name: "Test")
    let lhs = tree.addNode(
        ofType: ConstantNode()
    )

    let rhs = tree.addNode(
        ofType: ConstantNode()
    )

    let op = tree.addNode(ofType: MathNode())

    try tree.connect(from: lhs, atSocket: "Value", to: op, atSocket: "LHS")
    try tree.connect(from: rhs, atSocket: "Value", to: op, atSocket: "RHS")

    try tree.execute()

    let opNode = try tree.findNodeById(id: op)
    let result = try opNode.getOutputSocket(named: "Result").type.readValue()

    #expect(result == SocketValueType.numeric(2.0))
}

@Test func nodeConnectionTest() async throws {

    var tree = Tree(name: "Testing tree")

    let lhs = tree.addNode(
        ofType: ConstantNode()
    )

    let op = tree.addNode(ofType: MathNode())

    try tree.connect(from: lhs, atSocket: "Value", to: op, atSocket: "LHS")

    let test = try tree.findNodeById(id: lhs)

    #expect(!test.outputSockets.first!.value.connectedTo.isEmpty)
}

@Test func arithmeticConnectionTest() async throws {

    var tree = Tree(name: "Arithmetic tree")

    let lhs = tree.addNode(
        ofType: ConstantNode()
    )

    let rhs = tree.addNode(
        ofType: ConstantNode()
    )

    let op = tree.addNode(ofType: MathNode())

    try tree.connect(from: lhs, atSocket: "Value", to: op, atSocket: "LHS")
    try tree.connect(from: rhs, atSocket: "Value", to: op, atSocket: "RHS")

    let rhs2 = tree.addNode(
        ofType: ConstantNode()
    )

    let op2 = tree.addNode(ofType: MathNode())

    try tree.connect(from: op, atSocket: "Result", to: op2, atSocket: "LHS")
    try tree.connect(
        from: rhs2,
        atSocket: "Value",
        to: op2,
        atSocket: "RHS"
    )

    try tree.execute()

    let opNode = try tree.findNodeById(id: op2)
    let result = try opNode.getOutputSocket(named: "Result").type.readValue()

    #expect(result == SocketValueType.numeric(3.0))
}
