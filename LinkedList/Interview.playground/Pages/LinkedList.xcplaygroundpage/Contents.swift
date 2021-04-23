import Foundation

//MARK:- Node Definition
public class Node {
    
    //MARK:- Node Properties
    var value: String
    var next: Node?
    /* To avoid ownership cycles, we declare the previous pointer to be weak. If you have a node A that is followed by node B in the list, then A points to B but also B points to A. In certain Circumstances, this ownership cycle can cause nodes to be kept alive even after you've deleted them. We don't want that, so we make one of the pointers weak to break the cycles.
 */
    weak var previous: Node?
    
    //MARK:- Initialization
    init(value: String) {
        self.value = value
    }
}

//MARK:- LinkedList

public class LinkedList {
    //MARK:- LinkedList Properties
    fileprivate var head: Node?
    private var tail: Node?
    
    //MARK:- LinkedList Helper functions
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        return tail
    }
    
    //MARK:- LinkedList Methods
    /*
     Create a new Node to contain the value. Remember, the purpose of the Node
     class is so that each item in the linked list can point to the previous and next node.
     
     If tailNode is not nil, that means there is something in the linked list already.
     If that's the case, configure the new item to point to the tail of the list as it's previous items.
     Similarly, configure the new last item on the list to point to the newnode as it's next item.
     Finally, set the tail of the list to be the new item in either case
     */
    public func append(value: String) {
        let newNode = Node(value: value)
        
        if let tailNode = tail {
            newNode.previous = tailNode
            tailNode.next = newNode
        } else {
            head = newNode
        }
        tail = newNode
    }
    
    /*
     Add a check that the specified index is not negative. This prevents an infinite loop if the index is a negative value.
     Loop through the nodes until you reach the node at the specified index and return the node.
     If the index is less 0 or greater than the number of items in the list, then return nil
     */
    
    public func nodeAt(index: Int) -> Node? {
        if index >= 0 {
            var node = head
            var i = index
            while node != nil {
                if(i == 0) { return node}
                i -= 1
                node = node!.next
            }
        }
        return nil

    }
    
    /*
     Removing all nodes is simple. We just assign nil to the head and tail
     */
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    /*
     Removing Individual Nodes
     To remove an individual node, you will have to deal with three cases:
     1. Removing the First Node. This requires the head and previous pointers to be updated
     2. Removing a node in the middle of the list. This requires the previous and next pointers to be updated.
     3. Removing the last node in the list. This requires the next and tail pointers to be updated
     */
    
    /*
     Update the next pointer if you are not removing the first node in the list.
     Update the head pointer if you are  removing the first node in the list
     Update the previous pointer to the previous pointer of the deleted node.
     Update the tail if you are removing the last node in the list
     Assign nil to the removed nodes previous and next pointers
     Return the value for the removed node
     */
    
    public func remove(node: Node) -> String {
        let prev = node.previous
        let next = node.next
        
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

//MARK:- Extensions
extension LinkedList: CustomStringConvertible {
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
