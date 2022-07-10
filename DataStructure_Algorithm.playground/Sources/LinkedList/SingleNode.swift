import Foundation

public class SingleNode<Value> {
    public let value: Value
    
    public var next: SingleNode?
    
    public init(value: Value, next: SingleNode? = nil) {
        self.value = value
        self.next = next
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
