import Foundation

public final class DoublyNode<Value>: CommonNode<Value> {
    public var prev: DoublyNode<Value>?
    public var next: DoublyNode<Value>?
    
    public init(prev: DoublyNode<Value>? = nil, value: Value, next: DoublyNode<Value>? = nil) {
        self.prev = prev
        self.next = next
        super.init(value: value)
    }
}

extension DoublyNode: CustomStringConvertible {
    
    public var description: String {
        String(describing: value)
    }
}
