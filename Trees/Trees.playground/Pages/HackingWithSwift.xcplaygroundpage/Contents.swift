//: [Previous](@previous)

//Source: https://www.hackingwithswift.com/plus/data-structures/trees
import Foundation
// MARK:- Node Definition
final class Node<Value> {
    var value: Value
    // Making children read-only for external users, while keeping it modifiable for methods inside Node
    private(set) var children: [Node]
    
    var count: Int {
        1 + children.reduce(0) {$0 + $1.count}
    }
    
    //MARK:- Initialization
    /*
     Custom initialization: One accepts just a value, and one accepts a value and an array of children
     */
    
    init(_ value: Value) {
        self.value = value
        children = []
    }
    init(_ value: Value, children: [Node] ) {
        self.value = value
        self.children = children
    }
    
    // MARK:- Helper Functions
    
    
     func add(child: Node) {
        children.append(child)
    }
    
}

// MARK:- Extensions
/*
 1. Ability to compare one node against another, so we can tell if two nodes have the same value and children
 2. The Ability  to know the size of the tree, telling us how many items in total it is.
 3. The ability to find a specific node in the tree if it exists
 */

extension Node: Equatable where Value: Equatable {
    static func == (lhs: Node<Value>, rhs: Node<Value>) -> Bool {
        return lhs.value == rhs.value && lhs.children == rhs.children
    }
    
    func find(_ value: Value) -> Node? {
        if self.value == value {
            return self
        }
        for child in children {
            if let match = child.find(value) {
                return match
            }
        }
        return nil
    }
}
extension Node: Hashable where Value: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(children)
    }
}
extension Node: Codable where Value: Codable {}

