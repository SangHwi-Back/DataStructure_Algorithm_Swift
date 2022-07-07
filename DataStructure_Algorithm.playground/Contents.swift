import Foundation
import Darwin

// 1. Print in reverse
func printInReverse<T>(list: LinkedList<T>) {
    let startIndex = list.count - 1
    
    for index in 0..<list.count {
        if let node = list.node(of: startIndex-index) {
            print(node.value)
        }
    }
}

// 2. Find the middle node
func findTheMiddlenode<T>(list: LinkedList<T>) -> T? {
    let count = Int(floor(Double(list.count / 2)))
    return list.node(of: count)?.value
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
    var lhs = lhs
    var rhs = rhs
    
    while lhs.isEmpty == false || rhs.isEmpty == false {
        if lhs.head?.value == nil, let value = rhs.head?.value {
            resultList.append(value)
            rhs.pop()
        } else if let value = lhs.head?.value, rhs.head?.value == nil {
            resultList.append(value)
            lhs.pop()
        }
        
        guard let lhsValue = lhs.head?.value, let rhsValue = rhs.head?.value else {
            continue
        }
        
        if lhsValue > rhsValue {
            resultList.append(rhsValue)
            rhs.pop()
        } else if lhsValue < rhsValue {
            resultList.append(lhsValue)
            lhs.pop()
        } else if lhsValue == rhsValue {
            resultList.append(lhsValue)
            lhs.pop()
            rhs.pop()
        }
    }
    
    return resultList
}

// Remove All Occurrences
func removeAllOccurrences<T: Comparable>(list: LinkedList<T>, occurrence: T) -> LinkedList<T> {
    var index = 0
    var list = list
    
    if list.head?.value == occurrence {
        list.pop()
        return list
    }
    
    while list.isEmpty == false && index <= list.count-1 {
        if
            let node = list.node(of: index),
            let nextNode = list.node(of: index)?.next,
            nextNode.value == occurrence
        {
            list.remove(after: node)
        } else {
            index += 1
        }
    }
    
    return list
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
print(removeAllOccurrences(list: list, occurrence: 3))
