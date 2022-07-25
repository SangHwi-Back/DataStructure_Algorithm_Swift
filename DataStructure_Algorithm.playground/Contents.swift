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

print(nodeOne)
