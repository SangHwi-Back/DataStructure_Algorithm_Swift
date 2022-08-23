import Foundation

public struct BinarySearchTree<Element: Comparable> { // Comparable 은 == 함수를 구현하는 것으로도 대체 가능.
    
    public private(set) var root: BinaryNode<Element>?
    
    public init() {}
    public init(root: BinaryNode<Element>) {
        self.root = root
    }
}

// BinarySearchTree Challenge #2 - Equal BST
extension BinarySearchTree: Equatable {
    public static func == (lhs: BinarySearchTree, rhs: BinarySearchTree) -> Bool {
        isEqual(lhs.root, rhs.root)
    }
    
    private static func isEqual<Element: Equatable>(_ node1: BinaryNode<Element>?, _ node2: BinaryNode<Element>?) -> Bool {
        
        // 전달된 두 노드가 모두 nil 이면 true
        guard let leftNode = node1, let rightNode = node2 else {
            return node1 == nil && node2 == nil
        }
        
        // parent, leftChlid, rightChild 가 모두 같은지 검증하는 재귀 호출을 실행함.
        return leftNode.value == rightNode.value &&
            isEqual(leftNode.leftChild, rightNode.leftChild) &&
            isEqual(leftNode.rightChild, rightNode.rightChild)
    }
}

// BinarySearchTree Challenge #3 - SubTree
extension BinarySearchTree where Element: Hashable {
    public func contains(_ subTree: BinarySearchTree) -> Bool {
        var set: Set<Element> = []
        
        root?.traverseInOrder(visit: {
            set.insert($0)
        })
        
        var isEqual = true
        
        subTree.root?.traverseInOrder(visit: {
            isEqual = isEqual && set.contains($0)
        })
        
        return isEqual
    }
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
            
            current = (node.value > value ? node.leftChild : node.rightChild)
        }
        
        return false
    }
}

// 두 개의 자식 노드를 가진 노드를 지울 때는 다른 노드와 교체해 주어야 한다.
// 먼저 오른쪽 자식 노드로 이동한 다음에 왼쪽으로만 이동해서 나오는 Leaf 노드를 끌고와서 교체해준다.
private extension BinaryNode {
    var min: BinaryNode {
        leftChild?.min ?? self
    }
}

extension BinarySearchTree {
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>? {
        guard let node = node else {
            return nil
        }
        
        if value == node.value {
            
            if node.leftChild == nil && node.rightChild == nil { // 자식 노드 없음
                return nil
            }
            
            if node.leftChild == nil { // 오른쪽 자식 노드 없음. 자식 노드 하나.
                return node.rightChild
            }
            
            if node.rightChild == nil { // 왼쪽 자식 노드 없음. 자식 노드 하나.
                return node.leftChild
            }
            
            // rightChild에 rightChild가 지워진 노드를 반환하도록 다시 remove 를 호출한다.
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
