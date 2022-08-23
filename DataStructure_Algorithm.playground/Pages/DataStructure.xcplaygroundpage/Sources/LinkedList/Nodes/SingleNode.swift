import Foundation

public final class SingleNode<Value: Equatable> {
    public var value: Value
    public var next: SingleNode<Value>?
    
    public init(value: Value, next: SingleNode<Value>? = nil) {
        self.next = next
        self.value = value
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
