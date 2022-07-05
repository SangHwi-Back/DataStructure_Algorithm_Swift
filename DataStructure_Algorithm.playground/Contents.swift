import Foundation

var pushList = LinkedList<Int>()

pushList.push(3)
pushList.push(2)
pushList.push(1)

print(pushList)

var appendList = LinkedList<Int>()

appendList.append(1)
appendList.append(2)
appendList.append(3)

print(appendList)

var insertList = LinkedList<Int>()

insertList.push(3)
insertList.push(2)
insertList.push(1)

print("Before insert: \(insertList)")
var middleNode = insertList.node(of: 1)! // 2?

for _ in 1...4 {
    middleNode = insertList.insert(-1, after: middleNode)
}
print("After insert: \(insertList)")
