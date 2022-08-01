import Foundation

let lhsTree = BinarySearchTree<Int>.getTestTree()
var rhsTree = BinarySearchTree<Int>.getTestTree()
rhsTree.remove(5)
print(lhsTree)
print(rhsTree)
print(lhsTree==rhsTree)

let lhsSubTree = BinarySearchTree<Int>.init(root: lhsTree.root!.leftChild!)
