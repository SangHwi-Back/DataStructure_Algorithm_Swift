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

extension BinaryNode where Element == Int {
    public static func getTestTree() -> BinaryNode {
        let zero = BinaryNode(value: 0)
        let one = BinaryNode(value: 1)
        let five = BinaryNode(value: 5)
        let seven = BinaryNode(value: 7)
        let eight = BinaryNode(value: 8)
        let nine = BinaryNode(value: 9)

        seven.leftChild = one
        one.leftChild = zero
        one.rightChild = five
        seven.rightChild = nine
        nine.leftChild = eight

        return seven
    }
}

extension BinaryNode {
    public func height<T>(of node: BinaryNode<T>?) -> Int {
        guard let node = node else {
            return -1
        }
        
        return 1 + max(height(of: node.leftChild), height(of: node.rightChild))
    }
    
    public func serialize() -> [Element?] { // Solution of Challenge
        var array: [Element?] = []
        self.traversePreOrder { array.append($0) }
        return array
    }
}

/// BinaryTree Deserialize
public func deserialize<T>(_ array: inout [T?]) -> BinaryNode<T>? { // Solution of Challenge
    
    // 2
    guard let value = array.removeFirst() else {
        return nil
    }
    
    // 3
    let node = BinaryNode(value: value)
    node.leftChild = deserialize(&array)
    node.rightChild = deserialize(&array)
    return node
}

extension Array {
    public mutating func deserialize<T>() -> BinaryNode<T>? where Element == T? {
        guard let value = self.removeFirst() else {
            return nil
        }
        
        let node = BinaryNode<T>(value: value)
        node.leftChild = self.deserialize()
        node.rightChild = self.deserialize()
        return node
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
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}

extension BinaryNode {
    public func traversePreOrder(visit: (Element?) -> Void ) {
        visit(value)
        if let leftChild = leftChild {
            leftChild.traversePreOrder(visit: visit)
        } else {
            visit(nil)
        }
        if let rightChild = rightChild {
            rightChild.traversePreOrder(visit: visit)
        } else {
            visit(nil)
        }
    }
}
