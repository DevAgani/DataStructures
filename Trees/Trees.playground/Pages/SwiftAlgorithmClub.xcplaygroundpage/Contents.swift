// https://www.raywenderlich.com/1053-swift-algorithm-club-swift-tree-data-structure

/*
 Trees can help you solve many important problems, including
 1. Representing a heirarchical relationship between objects
 2. Making Searches quick and efficient
 3. Providing a Sorted List of data
 4. Powering Prefix matching in text fields
 */

/**
 Termninology:
 1. Root -> The Oth Level's node of a tree, this is the entry point to your tree
 2. Node -> A block of data in the tree structure. The data the node contains depends on the type of tree you're making, The root is also a node
 3. Leaf -> a Terminal Node, a leaf is simply a node with no children
 */

/*
 The idea of generics is to abstract away the type requirements from algorithms and data structures. This allows
 you to keep the idea generalized and reusable. Whether an object would behave well in a tree(or any other data structure) should not be whether it is an Int or a String, but rather something Intrinsic; in the context of trees, any type that behaves well in a hierarchy is a good candidate to be used in a tree
 */


import Foundation

class Node<T> {
    var value: T
    var children : [Node<T>] = []
    // Sometimes it's handy for each node to have a link to it's parent node, children are the nodes below a given node; the parent is the node above. A node may only have one parent, but can have multiple children
    // The Parent is optional since not all nodes have parents, such as the root node in a tree, we make it weak to avoid retain cycles
    weak var parent: Node<T>?
    
    //MARK:- Initialization
    init(value: T) {
        self.value = value
    }
    
    //MARK: Methods
    func add(child: Node<T>) {
        children.append(child)
        child.parent = self
    }
}

//MARK:- Extensions
extension Node: CustomStringConvertible {
    var description: String {
        var text = "\(value)"
        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }
}

extension Node: Equatable where T: Equatable {
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        lhs.value == rhs.value && lhs.children == rhs.children
    }
    /*
     1.The goal of this method is to search if a value exists in the tree. If it does, return the node associated with the value. If it doesn't exist, you'll return a nil
     If the value is found, you'll return self, which is the current node
     In the final loop, you'll cycle through the children array. You'll call each child's search method, which will recursively iterate through all the children. If any of the nodes have a match, your if let statement will evaluate to true and return the node.
     you'll return nil here to signify that you couldn't find a match
     */
    
    func search(value: T) -> Node<T>? {
        if value == self.value {
            return self
        }
        
        for child in children {
            if let found = child.search(value: value) {
                return found
            }
        }
        return nil
    }
}

extension Node: Hashable where T: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(children)
    }
}
