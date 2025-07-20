//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

import Foundation

public struct NumericSocket: SocketType {

    public var defaultValue: SocketValueType = .numeric(0)
    public var currentValue: SocketValueType
    
    init(defaultValue: SocketValueType) {
        currentValue = defaultValue
    }

    init() {
        currentValue = defaultValue
    }

    public mutating func setValue(to newValue: SocketValueType) throws {
        currentValue = newValue
    }

    public func readValue() throws -> SocketValueType {
        currentValue
    }

    
    public mutating func setToDefaultValue() {
        currentValue = defaultValue
    }
    
    public func readDefaultValue() -> SocketValueType {
        defaultValue
    }
    
}
