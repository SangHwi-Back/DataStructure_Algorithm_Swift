import Foundation

public class BinaryNode<Element>: CommonNode<Element> {
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    /// distance between root to leaf.
    public func height() -> Int {
        var result = 1
        var leftChild = leftChild
        
        while let child = leftChild {
            result += 1
            leftChild = child.leftChild
        }
        
        return result
    }
    
    // serialization => [15, 10, 5, nil, nil, 12, nil, nil, 25, 17, nil, nil, nil]
    public func serialization() -> Array<Element?> {
        
        var serialized = Array<Element?>()
        serialized.append(self.value)
        
        visitChild(from: self, as: &serialized)
        
        return serialized
    }
    
    private func visitChild(from node: BinaryNode<Element>, as serialized: inout Array<Element?>) {
        
        serialized.append(node.leftChild?.value)
        if let leftChild = node.leftChild {
            visitChild(from: leftChild, as: &serialized)
        }
        
        serialized.append(node.rightChild?.value)
        if let rightChild = node.rightChild {
            visitChild(from: rightChild, as: &serialized)
        }
    }
}

extension BinaryNode: CustomStringConvertible {
    public var description: String {
        diagram(for: self)
    }
    
    private func diagram(for node: BinaryNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        
        guard let node = node else {
            return root + "nil\n"
        }
        
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        
        return diagram(for: node.rightChild, top + " ", top + "┌──", top + "| ")
        + root + "\(node.value)\n"
        + diagram(for: node.leftChild, bottom + "| ", bottom + "└──", bottom + " ")
    }
}

extension BinaryNode {
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
        visit(value)
    }
}
