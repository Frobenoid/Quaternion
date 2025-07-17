//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

import Foundation

public enum SocketValueType: Equatable {
    case numeric(Float)

    func actualValue() -> Float {
        switch self {
        case .numeric(let value):
            return value
        }
    }
}

public protocol SocketType {

    var value: SocketValueType { get set }

    mutating func setValue(to newValue: SocketValueType) throws
    func readValue() throws -> SocketValueType
}
