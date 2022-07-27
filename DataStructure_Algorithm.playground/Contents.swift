import Foundation

var tree: BinaryNode<Int> = {
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
}()

print(tree)
print("---------------")
tree.traverseInOrder(visit: { print($0) })
print("---------------")
tree.traversePreOrder(visit: { print($0) })
print("---------------")
tree.traversePostOrder(visit: { print($0) })
print("---------------")
print("height is \(tree.height())")
print("---------------")
print(tree.serialization())

