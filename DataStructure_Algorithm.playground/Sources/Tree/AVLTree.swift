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
        
        let balanceNode = balanced(node)
        balanceNode.height = max(balanceNode.leftHeight, balanceNode.rightHeight) + 1
        
        return balanceNode
    }
    
    // Problem 앞의 R과 L은 문제가 발생하여 회전해야 하는 노드의 자식들이 어느 위치에 있는 지를 나타내는 것이다.
    
    // LL Problem
    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> { // node 는 회전하는 노드.
        
        let pivot = node.rightChild! // 축. 회전 시 고정. 나중에 root 혹은 parent가 됨.
        
        // 회전하는 노드는 leftChild가 되고, 축의 leftChild는 움직이는 노드의 rightChild가 된다. Balancing 작업.
        // Binary Search Tree 의 속성을 따르고 있음.
        node.rightChild = pivot.leftChild
        pivot.leftChild = node // 회전 완료!
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    // RR Problem
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.leftChild!
        
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    // RL Problem. right-rotation before left-rotation.
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else { return node }
        
        node.rightChild = rightRotate(rightChild) // right-rotation
        return leftRotate(node) // left-rotation
    }
    
    // LR Problem. left-rotation before right-rotation.
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else { return node }
        
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }
    
    private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        
        switch node.balanceFactor {
        case 2: // left-child is heavy
            print("case 2")
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 { // left-child's right-child is heavy
                return leftRightRotate(node)
            } else { // left-child's left-child is heavy
                return rightRotate(node)
            }
        case -2: // right-child is heavy
            print("case -2")
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 { // rigt-child's left-child is heavy
                return rightLeftRotate(node)
            } else { // right-child's right-child is heavy
                return leftRotate(node)
            }
        default:
            return node
        }
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
