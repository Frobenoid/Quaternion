//
//  NodeMetadata.swift
//  Quaternion
//
//  Created by Milton Montiel on 22/07/25.
//

public protocol NodeMetadata {
    var displayName: String { get }
    var desciption: String { get }
    var tags: Set<String> { get }
}
