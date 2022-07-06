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
