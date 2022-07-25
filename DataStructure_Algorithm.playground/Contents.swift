import Foundation

let root = TreeNode(value: 15)

let nodeOne = TreeNode(value: 1)
let nodeSeventeen = TreeNode(value: 17)
let nodeTwenty = TreeNode(value: 20)

root.add(nodeOne)
root.add(nodeSeventeen)
root.add(nodeTwenty)

nodeOne.add(TreeNode(value: 1))
nodeOne.add(TreeNode(value: 5))
nodeOne.add(TreeNode(value: 0))

nodeSeventeen.add(TreeNode(value: 2))

nodeTwenty.add(TreeNode(value: 5))
nodeTwenty.add(TreeNode(value: 7))

func printEachLevel<T>(for tree: TreeNode<T>) {
    
    let queue = QueueLinkedList<TreeNode<T>>()
    var nodesLeftInCurrentLevel = 0
    queue.enqueue(tree)
    
    while queue.isEmpty == false {
        
        nodesLeftInCurrentLevel = queue.count()
        
        while nodesLeftInCurrentLevel > 0 {
            guard let node = queue.dequeue() else { break }
            print("\(node.value) ", terminator: "")
            node.children.forEach { queue.enqueue($0) }
            nodesLeftInCurrentLevel -= 1
        }
        
        print()
    }
}

print(root)
printEachLevel(for: root)
