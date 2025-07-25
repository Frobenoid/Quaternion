//
//  NodeType.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

import Foundation

public protocol NodeType {
    var metadata: any NodeTypeMetadata { get }

    func declareNode(params b: inout ParametersBuilder)

    func execute(params p: inout ExecutionParameters) throws
}
