//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

import Foundation

public protocol Socket {
    var id: UUID { get }
    var name: String { get }
    var type: any SocketType { get set }

    mutating func connect(to socket: UUID)
}

public struct InputSocket: Socket {
    public var id: UUID = UUID()
    public var name: String
    public var type: any SocketType
    public var connectedTo: UUID?

    public init(
        named name: String,
        ofType type: any SocketType
    ) {
        self.name = name
        self.type = type
    }

    public mutating func connect(to socket: UUID) {
        self.connectedTo = socket
    }
}

public struct OutputSocket: Socket {
    public var id: UUID = UUID()
    public var name: String
    public var type: any SocketType
    public var connectedTo: Set<UUID> = []

    public init(
        named name: String,
        ofType type: any SocketType
    ) {
        self.name = name
        self.type = type
    }

    public mutating func connect(to socket: UUID) {
        self.connectedTo.insert(socket)
    }
}
