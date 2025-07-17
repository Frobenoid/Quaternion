//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

import Foundation

public struct NumericSocket: SocketType {
    public var value: SocketValueType = .numeric(0)

    init(defaultValue: SocketValueType) {
        value = defaultValue
    }

    init() {

    }

    public mutating func setValue(to newValue: SocketValueType) throws {
        value = newValue
    }

    public func readValue() throws -> SocketValueType {
        value
    }

}
