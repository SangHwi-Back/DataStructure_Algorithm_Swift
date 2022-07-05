import Foundation

// 이중 연결 리스트
public struct LinkedList<Value> {
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() { }
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        guard isEmpty == false else {
            push(value)
            return
        }
        
        tail?.next = Node(value: value)
        tail = tail?.next
    }
    
    public func node(of index: Int) -> Node<Value>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next) // 파라미터 node의 다음 node를 새로 만들고 next node는 파라미터 node의 next node로 바꿔준다.
        return node.next! // insert 된 Node.
    }
}

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else {
            return "Empty List"
        }
        
        return String(describing: head)
    }
}
