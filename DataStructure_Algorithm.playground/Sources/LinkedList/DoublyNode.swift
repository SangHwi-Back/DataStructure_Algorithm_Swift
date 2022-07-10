import Foundation

public class DoublyNode<Value> {
    public let value: Value
    
    public var prev: DoublyNode<Value>?
    public var next: DoublyNode<Value>?
    
    public init(prev: DoublyNode<Value>? = nil, value: Value, next: DoublyNode<Value>? = nil) {
        self.prev = prev
        self.value = value
        self.next = next
    }
}
