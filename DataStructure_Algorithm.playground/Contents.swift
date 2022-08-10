import Foundation

func numberOfLeaves(_ height: Int) -> Int {
    return Int(pow(2, Double(height)))
}

func numberOfNodes(_ height: Int) -> Int {
    var result = 0
    for num in 1...height {
        result += numberOfLeaves(num)
    }
    
    return result
}

var tree = AVLTree<Int>()

for i in 0..<15 {
    tree.insert(i)
    tree.root?.traverseInOrder(visit: { elem in
        print(elem)
    })
}
