//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

import Foundation

typealias SocketID = UUID
typealias NodeID = UUID

struct Tree {
    var id: UUID = UUID()
    var name: String
    var nodes: [NodeID: Node] = [:]
    var orderedNodes: [NodeID] = []
    var parentNode: [SocketID: NodeID] = [:]

    mutating func addNode(named name: String, ofType type: NodeType) -> UUID {
        let newNode = Node(named: name, ofType: type)
        nodes.updateValue(newNode, forKey: newNode.id)

        // Update parent node pointers
        for socket in newNode.inputSockets.keys {
            parentNode[socket] = newNode.id
        }

        for socket in newNode.outputSockets.keys {
            parentNode[socket] = newNode.id
        }

        return newNode.id
    }

    ///  Given nodes `A` and `B`, and sockets `a` from `A` and `b` from `B`, this function
    ///  calls ``a.connect(to: b)``, where `A` is `fromNode` and `B` is `toNode`.
    ///
    ///  This function does not propagate any values. Value propagation is defered until `NodeTree::execute()`
    ///  is called.
    mutating func connect(
        from: UUID,
        atSocket sourceSocketName: String,
        to: UUID,
        atSocket destinationSocketName: String
    ) throws {
        // Retrieve nodes.
        guard let fromNode = nodes[from] else {
            throw NodeError.nonExistentNodeWithId(from)
        }

        guard let toNode = nodes[to] else {
            throw NodeError.nonExistentNodeWithId(to)
        }

        // Retrieve sockets by name
        var sourceSocket = try fromNode.getOutputSocket(named: sourceSocketName)
        var destinationSocket = try toNode.getInputSocket(
            named: destinationSocketName
        )

        // Connect retrieved sockets
        sourceSocket.connect(to: destinationSocket.id)
        destinationSocket.connect(to: sourceSocket.id)

        // Update original nodes
        nodes[from]!.outputSockets[sourceSocket.id] = sourceSocket
        nodes[to]!.inputSockets[destinationSocket.id] = destinationSocket
    }

}

extension Tree {
    func findNodeById(id: UUID) throws -> Node {
        guard let result = nodes[id] else {
            throw NodeError.nonExistentNodeWithId(id)
        }
        return result
    }
}

extension Tree {
    /// Topologically sorts the tree nodes.
    mutating private func computeExecutionOrder() {

        // TODO: Implement ordering caching.

        var visited = Set<UUID>()
        var order: [UUID] = []

        func visit(_ node: Node) {
            if visited.contains(node.id) {
                return
            }

            for inputSocket in node.inputSockets.values {
                // Retrieve connected input.
                if let socketId = inputSocket.connectedTo {
                    let parentNode: Node = nodes[parentNode[socketId]!]!
                    visit(parentNode)
                }
            }

            visited.insert(node.id)
            order.append(node.id)
        }

        for node in nodes.values {
            if !visited.contains(node.id) {
                visit(node)
            }
        }

        orderedNodes = order
    }
}

extension Tree {
    mutating func propagateValues(for node: Node) throws {
        for outputSocket in node.outputSockets.values {
            for socketId in outputSocket.connectedTo {
                try nodes[parentNode[socketId]!]!.inputSockets[socketId]!.type
                    .setValue(
                        to: outputSocket.type.value
                    )
            }
        }
    }
}

extension Tree {
    mutating func execute() throws {
        computeExecutionOrder()

        for nodeID in orderedNodes {
            var execParams = ExecutionParameters(node: &nodes[nodeID]!)
            try nodes[nodeID]!.type.execute(params: &execParams)
            nodes[nodeID] = execParams.node
            try propagateValues(for: nodes[nodeID]!)
        }
    }
}
