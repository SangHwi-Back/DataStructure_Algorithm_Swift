import Foundation

/**
 AVL Tree
 - Tree에 요소를 추가할 때마다 self-balancing 하는 트리 구조이다.
 - balancing 은 문제가 되는 부분을 balancing 될 때까지 수정하는 방식으로 진행한다.
 - balancing 은 4 개의 종류를 가진 회전을 이용한다.
 
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
    /// BST 처럼 마지막 노드에 left or right-child 노드를 추가합니다.
    ///
    /// balanced 되어 있는지는 모르므로 balanced(_:) 함수를 실행한다.
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
    
    /// leftRotate. LL Problem을 해결합니다.
    ///
    /// 파라미터로 전달하는 노드의 right-child 노드를 축으로 삼아서 자신은 왼쪽으로 회전합니다. 즉, left-child 노드가 됩니다.
    ///
    /// 회전은 모든 노드의 BF(Balance factor)가 -1, 0, 1 중 하나가 될 때까지 반복될 수 있습니다.
    ///
    /// - Parameter node: 회전하려는 노드. 축은 해당 노드의 right-child 입니다.
    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        
        let pivot = node.rightChild!
        
        node.rightChild = pivot.leftChild
        pivot.leftChild = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    /// rightRotate. RR Problem을 해결합니다.
    ///
    /// 파라미터로 전달하는 노드의 left-child 노드를 축으로 삼아서 자신은 오른쪽으로 회전합니다. 즉, right-child 노드가 됩니다.
    ///
    /// 회전은 모든 노드의 BF(Balance factor)가 -1, 0, 1 중 하나가 될 때까지 반복될 수 있습니다.
    ///
    /// - Parameter node: 회전하려는 노드. 축은 해당 노드의 left-child 입니다.
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.leftChild!
        
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    /// rightLeftRotate. RL Problem을 해결합니다.
    ///
    /// 파라미터 노드 자신은 오른쪽으로 치우쳐져 있고, 파라미터 노드의 leaf 노드는 왼쪽으로 치우친 경우를 해결합니다.
    ///
    /// leaf 노드를 축으로 자신이 rightRotate 하면 leaf 노드가 파라미터 노드의 parent-node 가 됩니다. parent-node 가 된 leaf-node 는 leftRotate의 축이 되어 구조를 balanced 하게 만듭니다.
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else { return node }
        
        node.rightChild = rightRotate(rightChild) // right-rotation
        return leftRotate(node) // left-rotation
    }
    
    /// leftRightRotate. LR Problem을 해결합니다.
    ///
    /// 파라미터 노드 자신은 왼쪽으로 치우쳐져 있고, 파라미터 노드의 leaf 노드는 오른쪽으로 치우친 경우를 해결합니다.
    ///
    /// leaf 노드를 축으로 자신이 leftRotate 하면 leaf 노드가 파라미터 노드의 parent-node 가 됩니다. parent-node 가 된 leaf-node 는 rightRotate의 축이 되어 구조를 balanced 하게 만듭니다.
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else { return node }
        
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }
    
    /// 전달된 노드의 BF(Balance factor) 에 따라 회전을 하는 메소드입니다.
    ///
    /// - Parameter node: BF가 2일 경우 leftRightRotate 혹은 rightRotate, -2일 경우 rightLeftRotate 혹은 leftRotate 를 하게 됩니다.
    private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        
        switch node.balanceFactor {
        case 2:
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                return rightLeftRotate(node)
            } else {
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
        
        let balanceNode = balanced(node)
        balanceNode.height = max(balanceNode.leftHeight, balanceNode.rightHeight) + 1
        
        return balanceNode

    }
}
