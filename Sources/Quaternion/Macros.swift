//
//  Macros.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//

@freestanding(expression)
public macro fourCharacterCode(_ code: String) -> UInt32 = #externalMacro(module: "QuaternionMacros", type: "FourCharacterCode") 