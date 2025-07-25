//
//  NodeTypeMetadata.swift
//  Quaternion
//
//  Created by Milton Montiel on 24/07/25.
//

/// This specifies the metadata shared by all nodes of a given type.
public protocol NodeTypeMetadata {
    var name: String { get }
    var description: String { get }
    var tags: Set<String> { get }
}

public struct TypeMetadata: NodeTypeMetadata {
    public let name: String
    public let description: String
    public let tags: Set<String>
}
