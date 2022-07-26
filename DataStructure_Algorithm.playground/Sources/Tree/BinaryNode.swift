import Foundation

public class BinaryNode<Element>: CommonNode<Element> {
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
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
