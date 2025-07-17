// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct Node: Identifiable {

    public var id: UUID = UUID()
    public var name: String
    public var inputSockets: [UUID: InputSocket] = [:]
    public var outputSockets: [UUID: OutputSocket] = [:]

    public var type: any NodeType

    init(named name: String, ofType type: any NodeType) {
        self.name = name
        self.type = type

        var parametersBuilder = ParametersBuilder()

        type.declareNode(params: &parametersBuilder)

        (inputSockets, outputSockets) =
            parametersBuilder.parameters
    }
}

extension Node {
    func getInputSocket(id: UUID) throws -> InputSocket {
        if let result = inputSockets[id] {
            return result
        } else {
            throw NodeError.nonExistentNodeWithId(id)
        }
    }

    func getInputSocket(named name: String) throws -> InputSocket {
        if let result = inputSockets.values.first(where: { $0.name == name }) {
            return result
        } else {
            throw NodeError.nonExistentNode(name)
        }
    }

    func getOutputSocket(id: UUID) throws -> OutputSocket {
        if let result = outputSockets[id] {
            return result
        } else {
            throw NodeError.nonExistentNodeWithId(id)
        }
    }

    func getOutputSocket(named name: String) throws -> OutputSocket {
        if let result = outputSockets.values.first(where: { $0.name == name }) {
            return result
        } else {
            throw NodeError.nonExistentNode(name)
        }
    }
}
