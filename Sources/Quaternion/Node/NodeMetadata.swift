//
//  NodeMetadata.swift
//  Quaternion
//
//  Created by Milton Montiel on 22/07/25.
//

/// This is metadata owned by an instance of a node.
public protocol NodeMetadata {
    // TODO...
}

public class CoreMetadata: NodeMetadata {
    var isSelected: Bool = false
    var position: SIMD3<Float> = .zero
}
