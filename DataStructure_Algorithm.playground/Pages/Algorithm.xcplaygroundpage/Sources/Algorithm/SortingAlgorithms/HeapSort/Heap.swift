import Foundation

// Max Heap : higher value has higher priority
// Min Heap : lower value has lower priority
// Heap is a complete binary tree. Except last level, every level must be filled.

// Heap be used when calculate minimum/maximum, sort, construct priority queue or graph algorithms(Prim's / Dijkstra..)

// Heap can represent as an array. Using Heap is more efficient in time and space complexity.

// Node count multiplies 2 when level goes up by 1.
// Node at index i, left child node index is (2i+1), right child node index is (2i+2). Node's parent index is floor((i-1)/2)

/// Time Complexity:
///
///     Operation | Time Complexity
///     ----------+--------------------
///     remove    | O(log n)
///     ----------+--------------------
///     insert    | O(log n)
///     ----------+--------------------
///     search    | O(n)|
///     ----------+--------------------
///     peek      | O(n)|
public struct Heap<Element: Equatable> {
    public var elements: [Element]
    public let sort: (Element, Element) -> Bool
    
    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) { // 1번 요소가 2번 요소보다 높은 우선순위를 가지는지 검사한다.
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty {
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }
    
    public var isEmpty: Bool {
        elements.isEmpty
    }
    
    public var count: Int {
        elements.count
    }
    
    public func peek() -> Element? {
        elements.first
    }
    
    func leftChildIndex(ofParentAt index: Int) -> Int {
        (index * 2) + 1
    }
    
    func rightChildIndex(ofParentAt index: Int) -> Int {
        (index * 2) + 2
    }
    
    func parentIndex(ofChildAt index: Int) -> Int {
        (index - 1) / 2
    }
    
    public mutating func remove() -> Element? {
        guard !isEmpty else {
            return nil
        }
        
        elements.swapAt(0, count-1)
        
        defer {
            siftDown(from: 0)
        }
        
        return elements.removeLast()
    }
    
    mutating func siftDown(from index: Int) { // index의 노드를 한칸 위로 올린다.
        var parent = index
        
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            
            var candidate = parent
            
            if left < count && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            
            if right < count && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            
            if candidate == parent {
                return
            }
            
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    mutating func siftDown(from index: Int, upTo: Int) { // index의 노드를 한칸 위로 올린다.
        var parent = index
        
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            
            var candidate = parent
            
            if left < upTo && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            
            if right < upTo && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            
            if candidate == parent {
                return
            }
            
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    public mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count-1)
    }
    
    mutating func siftUp(from index: Int) { // index의 노드를 한칸 내린다.
        var child = index
        var parent = parentIndex(ofChildAt: child)
        
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }
    
    public mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else {
            return nil
        }
        
        if index == elements.count - 1 {
            return elements.removeLast()
        }
        else {
            elements.swapAt(index, elements.count - 1)
            
            defer {
                siftDown(from: index)
                siftUp(from: index)
            }
            
            return elements.removeLast()
        }
    }
    
    public func index(of element: Element, startingAt i: Int) -> Int? {
        if i >= count {
            return nil
        }
        if sort(element, elements[i]) {
            return nil
        }
        if element == elements[i] {
            return i
        }
        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) { // 왼쪽 child에서 element 찾음
            return j
        }
        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) { // 오른쪽 child에서 element 찾음
            return j
        }
        return nil
    }
    
    func isMinHeap<Element: Comparable>(elements: [Element]) -> Bool {
        guard !elements.isEmpty else {
            return true
        }
        
        for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
            
            let left = leftChildIndex(ofParentAt: i)
            let right = rightChildIndex(ofParentAt: i)
            
            if elements[left] < elements[i] {
                return false
            }
            
            if right < elements.count && elements[right] < elements[i] {
                return false
            }
        }
        
        return true
    }
}

extension Heap: CustomStringConvertible {
    public var description: String {
        diagram()
    }
    
    private func diagram() -> String {
        guard self.count > 0 else {
            return ""
        }
        
        var nodeCount = 1
        var result = ""
        
        for (index, elem) in elements.enumerated() {
            result += "\(elem) "
            
            if nodeCount == index+1 {
                let level = (nodeCount/2) // 0, 1, 2, 3
                nodeCount += Int(truncating: pow(2, level) as NSNumber)
                
                result += "\n"
            }
        }
        
        return result
    }
}

extension Array where Element: Comparable {
    
    func leftChildIndex(ofParent index: Int) -> Int {
        (2 * index) + 1
    }
    
    func rightChildIndex(ofParent index: Int) -> Int {
        (2 * index) + 2
    }
    
    mutating func siftDown(from index: Int, upTo size: Int) {
        var parent = index
        while true {
            
            let left = leftChildIndex(ofParent: parent)
            let right = rightChildIndex(ofParent: parent)
            
            var candidate = parent
            
            if (left < size) && (self[left] > self[candidate]) {
                candidate = left
            }
            
            if (right < size) && (self[right] > self[candidate]) {
                candidate = right
            }
            
            if candidate == parent {
                return
            }
            
            swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    mutating public func makeHeapSort() -> Self {
        return Heap(sort: <, elements: self).sorted().reversed()
    }
    
    mutating public func heapSort() {
        if !isEmpty {
            for i in stride(from: count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i, upTo: count)
            }
        }
        
        for index in indices.reversed() {
            swapAt(0, index)
            siftDown(from: 0, upTo: index)
        }
    }
}
