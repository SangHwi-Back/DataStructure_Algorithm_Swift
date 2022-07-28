import Foundation

public struct BinarySearchTree<Element: Comparable> { // Comparable 은 == 함수를 구현하는 것으로도 대체 가능.
    
    public private(set) var root: BinaryNode<Element>?
    
    public init() {}
}

extension BinarySearchTree {
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        guard let node = node else { // 이전에 지나친 노드가 Leaf 였습니다.
            return BinaryNode(value: value)
        }
        
        if value < node.value { // Thanks for Comparable.
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        
        return node
    }
}

extension BinarySearchTree {
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

extension BinarySearchTree where Element == Int {
    static public func getTestTree() -> BinarySearchTree {
        var bst = BinarySearchTree<Int>()
        bst.insert(3)
        bst.insert(1)
        bst.insert(4)
        bst.insert(0)
        bst.insert(2)
        bst.insert(5)
        return bst
    }
}

extension BinarySearchTree: CustomStringConvertible {
    
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}

/**
 Case Study #1 : array vs BST
 
 (Lookup)
 array의 contains(_:) 메소드는 O(n) 시간 복잡도를 갖는다. 목표한 요소를 찾기 전까지는 모든 요소를 거쳐야 하기 때문이다.
 BST는 Root 노드부터 비교해볼 때 목표한 요소보다 적다면 왼쪽 노드, 크다면 오른쪽 노드로 가면서 탐색하면 되기 때문에 O(log n) 시간 복잡도를 갖는다.
 
 (Insertion)
 array의 경우 위와 같다. 특정 위치에 요소를 삽입하면 그 뒤의 요소는 모두 shift가 일어난다.
 BST는 위의 탐색을 거치면서 적당한 위치에 추가해주기만 하면 된다. (작다면 왼쪽 하위노드, 크거나 같다면 오른쪽 하위노드)
 
 (Removal)
 array, BST 모두 위와 같다.
 */
