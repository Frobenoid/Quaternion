//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

import Foundation

enum NodeError: Error {
    case nonExistentNode(String)
    case nonExistentNodeWithId(UUID)
    case nonExistentSocket(withID: UUID)
}

enum SocketError: Error {
    case uninitializedSocket(UUID)
    case castingError(from: any Sendable, to: any Sendable)
}
