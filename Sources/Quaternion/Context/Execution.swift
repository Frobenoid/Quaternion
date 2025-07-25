//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

import Foundation

/// Allows to retrieve and set the parameters of a node.
public struct ExecutionParameters {

    var node: Node

    // TODO: This does not need to be inout.
    init(node: inout Node) {
        self.node = node
    }

    func getInputValue<T>(named name: String) throws -> T {
        let socket = try node.getInputSocket(named: name)
        let value = try socket.type.readValue().actualValue()

        guard let typedValue = value as? T else {
            throw SocketError.castingError(from: value.self, to: T.self)
        }

        return typedValue

    }

    mutating func setOutput(named name: String, to newValue: SocketValueType)
        throws
    {
        let temp = try node.getOutputSocket(named: name)
        try node.outputSockets[temp.id]!.type.setValue(to: newValue)
    }
}
