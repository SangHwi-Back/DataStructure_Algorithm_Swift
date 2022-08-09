import Foundation

var tree = AVLTree<Int>()

for i in 0..<15 {
    tree.insert(i)
}

print(tree)
