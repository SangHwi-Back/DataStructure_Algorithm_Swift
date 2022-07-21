import Foundation

public class TreeNode<T>: CommonNode<T> {
    public var children: [TreeNode] = []
    
    public func add(_ child: TreeNode) {
        children.append(child)
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var result = "\(value)"
        let children = children
        
        let resultCount = result.count
        
        if let first = children.first {
            result += " -> \(first.value)"
            
            if first.children.isEmpty == false {
                result += first.description
            }
        }
        
        if let last = children.last {
            result += "\n\([String](repeating: " ", count: resultCount).reduce("", +))    \(last.value)"
            
            if last.children.isEmpty == false {
                result += last.description
            }
        }
        
        return result
    }
}
