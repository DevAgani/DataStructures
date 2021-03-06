//: [Previous](@previous)

// Source: https://www.raywenderlich.com/947-swift-algorithm-club-swift-linked-list-data-structure
import Foundation

//MARK:- GenericNode Definition
public class GenericNode<T> {
    
    //MARK:- Properties
    
    var value: T
    var next: GenericNode<T>?
    weak var previous: GenericNode<T>?
    
    //MARK:- Initialization
    
    init(value: T) {
        self.value = value
    }
}

// MARK:- GenericLinkedList Definition
public class GenericLinkedList<T> {
    
    //MARK:- Properties
    fileprivate var head: GenericNode<T>?
    private var tail: GenericNode<T>?
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: GenericNode<T>? {
        return head
    }
    
    public var last: GenericNode<T>? {
        return tail
    }
    
    // MARK:- Convenience Functions
    
    public func append(value: T) {
        let newNode = GenericNode(value: value)
        
        if let tailNode = tail {
            newNode.previous = tail
            tailNode.next = newNode
        } else {
            head = newNode
        }
        
        tail = newNode
    }
    
    public func nodeAt(index: Int) -> GenericNode<T>? {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if i == 0 { return node}
                i -= 1
                node = node!.next
            }
        }
        return nil
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    public func remove(node: GenericNode<T>) -> T {
        let next = node.next
        let prev = node.previous
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
}

// MARK:- Extensions

extension GenericLinkedList: CustomStringConvertible {
    public var description: String {
        var text = "["
        var node = head
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil { text += ", "}
        }
        return text + "]"
    }
}


//let dogBreeds = GenericLinkedList<String>()
//dogBreeds.append(value: "Labrador")
//dogBreeds.append(value: "Bulldog")
//dogBreeds.append(value: "Beagle")
//dogBreeds.append(value: "Husky")
//
//print(dogBreeds)
//
//print(dogBreeds)

let numbers = GenericLinkedList<Int>()
numbers.append(value: 5)
numbers.append(value: 10)
numbers.append(value: 15)

print(numbers)
