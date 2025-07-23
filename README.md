# Quaternion 

> 🚧 **Work in progress**: Quaternion is under development. APIs will change over time and some features are not yet complete.

## Overview 

Quaternion provides a flexible, type-safe system for creating node-based applications in Swift. The main use case for this 
packaged is the construction of visual programming tools, but general data processing pipelines can be built too. 

Quaternion aims to offer the building blocks for constructing and executing complex node trees. 

# Quick Start

```swift
import Quaternion

// Create new tree
let tree = Tree(name: "Computation")

// Add nodes
let constantA = tree.addNode(ofType: ConstantNode())
let constantB = tree.addNode(ofType: ConstantNode())
let mathNode = tree.addNode(ofType: MathNode())

// Set values
try tree.setDefaultValue(to: .numeric(5), forNode: constantA, atSocket: "Value")
try tree.setDefaultValue(to: .numeric(3), forNode: constantB, atSocket: "Value")

// Connect nodes
try tree.connect(from: constantA, atSocket: "Value", to: mathNode, atSocket: "LHS")
try tree.connect(from: constantB, atSocket: "Value", to: mathNode, atSocket: "RHS")

// Executre the tree
tree.execute()

// Retrieve the result
let result = try tree.getSocketValue(forNode: mathNode, atSocket: "Result")
print(result)
```
