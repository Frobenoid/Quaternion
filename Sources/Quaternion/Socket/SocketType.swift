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

    var defaultValue: SocketValueType { get }
    var currentValue: SocketValueType { get set }

    mutating func setValue(to newValue: SocketValueType) throws
    mutating func setToDefaultValue()

    func readValue() throws -> SocketValueType
    func readDefaultValue() -> SocketValueType
}
