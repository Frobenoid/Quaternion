//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

import Foundation

public struct ParametersBuilder {
    var inputs: [UUID: InputSocket] = [:]
    var outputs: [UUID: OutputSocket] = [:]

    public var parameters: ([UUID: InputSocket], [UUID: OutputSocket]) {
        (inputs, outputs)
    }

    mutating func addInput(
        named name: String,
        ofType type: any SocketType
    ) {
        let socket = InputSocket(named: name, ofType: type)
        inputs.updateValue(
            socket,
            forKey: socket.id
        )
    }

    mutating func addOutput(
        named name: String,
        ofType type: any SocketType
    ) {
        let socket = OutputSocket(named: name, ofType: type)
        outputs.updateValue(socket, forKey: socket.id)
    }
}
