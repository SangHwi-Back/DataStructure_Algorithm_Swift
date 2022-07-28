import Foundation

let tree = BinaryNode<Int>.getTestTree()

print(tree)
print("---------")
var serializedTree = tree.serialize()
print(serializedTree)
print("---------")
print(deserialize(&serializedTree))
var serializedTree2 = tree.serialize()
print(serializedTree2.deserialize())
