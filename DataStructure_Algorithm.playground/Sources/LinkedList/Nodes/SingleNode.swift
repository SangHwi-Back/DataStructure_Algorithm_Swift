import Foundation

public final class SingleNode<Value>: Node<Value> {
    public var next: SingleNode<Value>?
    
    public init(value: Value, next: SingleNode<Value>? = nil) {
        self.next = next
        super.init(value: value)
    }
}

extension SingleNode: CustomStringConvertible {
    
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        
        return "\(value) -> " + String(describing: next) + " "
    }
}
