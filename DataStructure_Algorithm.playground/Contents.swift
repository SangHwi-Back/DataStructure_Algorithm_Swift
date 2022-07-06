import Foundation

var collectionList = LinkedList<Int>()

for i in 0...9 {
    collectionList.append(i)
}

print("List: \(collectionList)")
print("First element: \(collectionList[collectionList.startIndex])")
print("Array containing first 3 elements: \(Array(collectionList.prefix(3)))")
print("Array containing last 3 elements: \(Array(collectionList.suffix(3)))")

let sum = collectionList.reduce(0, +)
print("Sum of all values: \(sum)")

var list1 = LinkedList<Int>()
list1.append(1)
list1.append(2)
var list2 = list1
print("List1: \(list1)")
print("List2: \(list2)")

print("After appending 3 to list2")
list2.append(3)
print("List1: \(list1)")
print("List2: \(list2)")
