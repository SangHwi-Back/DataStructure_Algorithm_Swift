import Foundation

public class CommonNode<Value>: Equatable {
    
    private let id = UUID()
    
    public var value: Value
    
    public init(value: Value) {
        self.value = value
    }
    
    public static func == (lhs: CommonNode<Value>, rhs: CommonNode<Value>) -> Bool {
        lhs.id == rhs.id
    }
}
