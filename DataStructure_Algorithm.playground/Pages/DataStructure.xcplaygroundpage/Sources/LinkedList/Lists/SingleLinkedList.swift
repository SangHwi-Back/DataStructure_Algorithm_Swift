import Foundation

public struct SingleLinkedList<Value: Equatable> {
    
    public typealias Node = SingleNode<Value>
    
    public var head: Node?
    public var tail: Node?
    
    public init() { }
    
    public var isEmpty: Bool {
        head == nil
    }
    
    /// O(1)
    public mutating func push(_ value: Value) {
        
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    /// O(1)
    public mutating func append(_ value: Value) {
        
        guard isEmpty == false else {
            push(value)
            return
        }
        
        tail?.next = Node(value: value)
        tail = tail?.next
    }
    
    /// O(n-index)
    public func node(at index: Int) -> Node? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    /// O(1)
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node) -> Node {
        
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next) // 파라미터 node의 다음 node를 새로 만들고 next node는 파라미터 node의 next node로 바꿔준다.
        return node.next! // insert 된 Node.
    }
    
    /// O(1)
    @discardableResult
    public mutating func pop() -> Value? {
        
        defer {
            head = head?.next // head 가 사라질 것이므로, head 자리를 head.next가 대체함.
            if isEmpty {
                tail = nil
            }
        }
        
        return head?.value
    }
    
    /// O(n)
    @discardableResult
    public mutating func removeLast() -> Value? { // 맨 뒤의 노드 전의 노드를 찾아야 하는 과정이 오래걸림. Node는 이전 노드를 기억하지 않음.
        
        guard let head = head else {
            return nil
        }
        
        guard head.next != nil else {
            return pop()
        }
        
        var prev: Node?
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev?.next = nil
        tail = prev
        return current.value
    }
    
    /// O(1)
    @discardableResult
    public mutating func remove(after node: Node) -> Value? {
        
        guard let node = copyNodes(returningCopyOf: node) else { return nil }
        
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        
        return node.next?.value
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
}

extension SingleLinkedList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else {
            return "Empty List"
        }
        
        return String(describing: head)
    }
}

extension SingleLinkedList: Collection {
    
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
