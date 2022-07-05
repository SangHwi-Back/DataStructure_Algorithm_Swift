import Foundation

var popList = LinkedList<Int>()
popList.push(3)
popList.push(2)
popList.push(1)

print("Before popping list: \(popList)")
let poppedValue = popList.pop()
print("After popping list: \(popList)")
print("Popped value: " + String(describing: poppedValue))

var lastList = LinkedList<Int>()
lastList.push(3)
lastList.push(2)
lastList.push(1)

print("Before removing last list: \(lastList)")
let removedValue = lastList.removeLast()
print("After removing last list: \(lastList)")
print("Removed value: " + String(describing: removedValue))

var removeList = LinkedList<Int>()
removeList.push(3)
removeList.push(2)
removeList.push(1)

print("Before removing at particular index: \(removeList)")
let index = 1
let node = removeList.node(of: index - 1)!
let removedValue2 = removeList.remove(after: node)
print("After removing at particular index \(index): \(removeList)")
print("Removed value: " + String(describing: removedValue2))
