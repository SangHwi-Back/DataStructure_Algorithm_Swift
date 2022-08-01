import Foundation

// 1. Binary tree or binary search tree
func isBinarySearch(tree: BinaryNode<Int>) -> Bool {
    guard let leftChild = tree.leftChild else {
        return false
    }
    
    if let rightChild = tree.rightChild, leftChild.value <= rightChild.value, tree.value <= rightChild.value {
        return true
    }
    
    return false
}

//let lhsTree = BinarySearchTree<Int>.getTestTree()
//var rhsTree = BinarySearchTree<Int>.getTestTree()
//rhsTree.remove(5)
//print(lhsTree)
//print(rhsTree)
//print(lhsTree==rhsTree)

struct User {
    let id: String
    var contents = Set<String>()
}

func solution(_ id_list:[String], _ report:[String], _ k:Int) -> [Int] {
    
    var reported: [String: Int] = [:]
    var user: [String: [String]] = [:]
    
    for r in Set(report) {
        
        let splitted = r.split(separator: " ").map({ String($0) })
        let reporter = splitted[0]
        let reportee = splitted[1]
        
        user[reporter] = (user[reporter] ?? []) + [reportee]
        reported[reportee] = (reported[reportee] ?? 0) + 1
    }
    
    return id_list.map { id in
        return (user[id] ?? []).reduce(0) {
            $0 + ((reported[$1] ?? 0) >= k ? 1 : 0)
        }
    }
}

print(solution(["con", "ryan"], ["ryan con", "ryan con", "ryan con", "ryan con"], 3))
