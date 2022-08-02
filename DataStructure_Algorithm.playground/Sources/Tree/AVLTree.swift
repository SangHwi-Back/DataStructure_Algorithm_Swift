import Foundation

/**
 Balanced Binary Tree
 Balance의 종류
    Perfect balance = 모든 노드 뿐 아니라 자식 노드들까지 모든 레벨에서 동일하게 완벽히 채워진 상태.
    Good-enough balance = 각 노드의 맨 아래 레벨은 모두 채워졌지만, 자식 노드들까지 모든 레벨이 채워지진 않은 상태.
    Unbalanced = 각 노드의 아래 레벨과 맨 아래 레벨 모두 정확히 채워지지 않은 노드가 존재하는 상태. 퍼포먼스 저하가 발생할 가능성이 있음.
 Balance 상태의 tree 는 find, insert, remove 동작에 대해 O(log n) 시간 복잡도를 보장한다.
 */

public struct AVLTree<Element: Comparable> {
    public private(set) var root: AVLNode<Element>?
    public init() {}
}

extension AVLTree: CustomStringConvertible {
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}

extension AVLTree {
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
        guard let node = node else {
            return AVLNode(value: value)
        }
        
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        return node
    }
}

extension AVLTree {
    public func contains(_ value: Element) -> Bool {
        var current = root
        
        while let node = current {
            if node.value == value {
                return true
            }
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        
        return false
    }
}

private extension AVLNode {
    var min: AVLNode {
        leftChild?.min ?? self // min값은 맨 왼쪽
    }
}

extension AVLTree {
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
        guard let node = node else {
            return nil
        }
        
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        
        return node

    }
}
