import Foundation
import Darwin

// 1. Print in reverse O(n * n)
func printInReverse<T>(list: LinkedList<T>) {
    let startIndex = list.count - 1
    
    for index in 0..<list.count {
        if let node = list.node(at: startIndex-index) {
            print(node.value)
        }
    }
}

// 2. Find the middle node
func findTheMiddlenode<T>(list: LinkedList<T>) -> T? {
    let count = Int(floor(Double(list.count / 2)))
    return list.node(at: count)?.value
}

// 3. Reverse a linked list
func reverseLinkedList<T>(list: LinkedList<T>) -> LinkedList<T> {
    var resultList = LinkedList<T>()
    var list = list
    var safeCount = 10
    
    while list.isEmpty == false {
        
        if let value = list.pop() {
            resultList.push(value)
        }
        
        safeCount -= 1
        
        if safeCount == 0 {
            break
        }
    }
    
    return resultList
}

// 4. Merge two lists
/**
 - parameters:
    - lhs: 정렬된 연결 리스트1
    - rhs: 정렬된 연결 리스트2
 - returns: 연결 리스트 1, 2 를 합친 연결 리스트. 정렬 된 상태여야 함.
 */
func mergeTwoLists<T: Comparable>(lhs: LinkedList<T>, rhs: LinkedList<T>) -> LinkedList<T> {
    var resultList = LinkedList<T>()
    var leftList = LinkedList<T>()
    for value in lhs {
        leftList.append(value)
    }
    var rightList = LinkedList<T>()
    for value in rhs {
        rightList.append(value)
    }
    
    while leftList.isEmpty == false || rightList.isEmpty == false {
        if leftList.head?.value == nil, let value = rightList.head?.value {
            resultList.append(value)
            rightList.pop()
        } else if let value = leftList.head?.value, rightList.head?.value == nil {
            resultList.append(value)
            leftList.pop()
        }
        
        guard let lhsValue = leftList.head?.value, let rhsValue = rightList.head?.value else {
            continue
        }
        
        if lhsValue > rhsValue {
            resultList.append(rhsValue)
            rightList.pop()
        } else if lhsValue < rhsValue {
            resultList.append(lhsValue)
            leftList.pop()
        } else if lhsValue == rhsValue {
            resultList.append(lhsValue)
            leftList.pop()
            rightList.pop()
        }
    }
    
    return resultList
}

// Remove All Occurrences
func removeAllOccurrences<T: Comparable>(list: LinkedList<T>, occurrence: T) -> LinkedList<T> {
    
    var newList = LinkedList<T>()
    for value in list {
        newList.append(value)
    }
    
    if newList.head?.value == occurrence {
        while newList.head?.value == occurrence {
            newList.pop()
        }
        
        return newList
    }
    
    var index = 0
    
    while newList.isEmpty == false && index <= newList.count-1 {
        
        guard let compareNode = newList.node(at: index) else {
            index += 1
            continue
        }
        
        if compareNode.next?.value == occurrence {
            newList.remove(after: compareNode)
        } else {
            index += 1
        }
    }
    
    return newList
}

var list = LinkedList<Int>()
list.append(1)
list.append(3)
list.append(3)
list.append(3)
list.append(4)

print(printInReverse(list: list))
print("----")
print(findTheMiddlenode(list: list))
print("----")
print(reverseLinkedList(list: list))
print("----")
var rightList = LinkedList<Int>()
rightList.append(-1)
rightList.append(4)
rightList.append(5)
rightList.append(9)
print(list, rightList)
print(mergeTwoLists(lhs: list, rhs: rightList))
print(mergeSorted(list, rightList)!)
print("----")
print(removeAllOccurrences(list: list, occurrence: 3))
