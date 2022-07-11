import Foundation

// 원형 연결 리스트
public struct DoublyLinkedList<Value: Equatable> {
    
    public typealias Node = DoublyNode<Value>
    
    public var head: Node?
    public var tail: Node?
    
    public init() { }
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public var first: Node? {
        head
    }
    
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        let newNode = Node(value: value)
        
        guard let tailNode = tail else {
            head = newNode
            tail = newNode
            return
        }
        
        newNode.prev = tailNode
        tailNode.next = newNode
        tail = newNode
    }
    
    public func node(at index: Int) -> Node? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node) -> Node {
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(prev: node, value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            head?.prev = nil
            if isEmpty {
                tail = nil
            }
        }
        
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        
        defer {
            tail = tail?.prev
            tail?.next = nil
        }
        
        return tail?.value
    }
    
    @discardableResult
    public mutating func remove(after node: Node) -> Value? {
        guard let node = copyNodes(returningCopyOf: node) else {
            return nil
        }
        
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        
        return node.next?.value
    }
    
    public mutating func remove(_ element: Value) -> Value? {
        
        guard head?.value != element else {
            return pop()
        }
        
        var current = head
        while let node = current?.next {
            if node.value == element, let current = current {
                return remove(after: current)
            }
            
            current = node
        }
        
        return nil
    }
    
    private mutating func copyNodes() {
        guard var oldNode = head else {
            return
        }
        
        head = Node(value: oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        
        tail = newNode
    }
    
    private mutating func copyNodes(returningCopyOf node: Node?) -> Node? {
        
        guard !isKnownUniquelyReferenced(&head) else {
            return nil
        }
        
        guard var oldNode = head else { // 복사하고 싶은 대상
            return nil
        }
        
        head = Node(value: oldNode.value)
        var newNode = head
        var nodeCopy: Node?
        
        while let nextOldNode = oldNode.next {
            if oldNode === node {
                nodeCopy = newNode
            }
            
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        
        return nodeCopy
    }
    
    func count() -> Int {
        guard head == nil else {
            return 0
        }
        
        var current = head
        var result = 1
        while let node = current?.next {
            current = node
            result += 1
        }
        
        return result
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else {
            return "Empty List"
        }
        
        var current = head
        var result = "\(current.value)"
        while let node = current.next {
            result += " -> "
            result += "\(node.value)"
            current = node
        }
        
        return result
    }
}

extension DoublyLinkedList: Collection {
    
    public var startIndex: Index {
        Index(node: head)
    }
    
    public var endIndex: Index {
        Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> Value {
        position.node!.value
    }
    
    public struct Index: Comparable {
        
        public var node: Node?
        
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
}
