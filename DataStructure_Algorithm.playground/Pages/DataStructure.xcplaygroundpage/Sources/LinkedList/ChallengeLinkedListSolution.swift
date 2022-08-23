import Foundation

// 1. Print in reverse
private func printInReverse<T>(_ list: SingleLinkedList<T>) {
    printInReverse(list.head)
}

private func printInReverse<T>(_ node: SingleNode<T>?) {
    guard let node = node else { return }
    printInReverse(node.next)
    print(node.value)
}

// 2. Find the middle node
private func getMiddle<T>(_ list: SingleLinkedList<T>) -> SingleNode<T>? {
    var slow = list.head
    var fast = list.head // 2 배 빠른 탐색을 진행함.
    
    while let nextFast = fast?.next { // fast next 이동.
        fast = nextFast.next // fast next 이동.
        slow = slow?.next // slow next 이동. fast 2번 할 때 slow 1번 탐색함.
    }
    
    return slow
}

// 3. Reverse a linked list
extension SingleLinkedList {
    mutating func reverse() {
        tail = head
        var prev = head
        var current = head?.next
        prev?.next = nil
        
        while current != nil {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        
        head = prev
    }
}

// 4. Merge two lists
public func mergeSorted<T: Comparable>(_ left: SingleLinkedList<T>, _ right: SingleLinkedList<T>) -> SingleLinkedList<T>? {
    
    guard !left.isEmpty else { return right }
    
    guard !right.isEmpty else { return left }
    
    var newHead: SingleNode<T>?
    var tail: SingleNode<T>?
    
    var currentLeft = left.head
    var currentRight = right.head
    
    if let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.value < rightNode.value {
            newHead = leftNode
            currentLeft = leftNode.next
        } else {
            newHead = rightNode
            currentRight = rightNode.next
        }
        
        tail = newHead
    }
    
    while let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.value < rightNode.value {
            tail?.next = leftNode
            currentLeft = leftNode.next
        } else {
            tail?.next = rightNode
            currentRight = rightNode.next
        }
        
        tail = tail?.next
    }
    
    if let leftNodes = currentLeft {
        tail?.next = leftNodes
    }
    
    if let rightNodes = currentRight {
        tail?.next = rightNodes
    }
    
    var list = SingleLinkedList<T>()
    list.head = newHead
    list.tail = {
        while let next = tail?.next {
            tail = next
        }
        return tail
    }()
    
    return list
}

// Remove All Occurrences ???
