//
//  File.swift
//  Quaternion
//
//  Created by Milton Montiel on 16/07/25.
//
import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct QuaternionMacros: CompilerPlugin {
    var providingMacros: [Macro.Type] = [FourCharacterCode.self]
}
