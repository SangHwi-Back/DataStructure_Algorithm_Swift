import Foundation

public class CommonNode<Value: Equatable> {
    
    public var value: Value
    
    public init(value: Value) {
        self.value = value
    }
    
//    public static func == (lhs: CommonNode<Value>, rhs: CommonNode<Value>) -> Bool {
//        lhs.value == rhs.value
//    }
}
