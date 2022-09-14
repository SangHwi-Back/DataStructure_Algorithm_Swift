import Foundation

public func quicksortIterativeLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    
    var stack = Stack<Int>() // 정렬해야 할 범위를 담은 Stack.
    stack.push(low)
    stack.push(high)
    
    while !stack.isEmpty {
        guard let end = stack.pop(), let start = stack.pop() else {
            continue
        }
        
        let pivotIndex = partitionLomuto(&a, low: start, high: end)
        
        // 겹치는지 확인해보고 겹치지 않으면 정렬해야 할 범위 (less, greater) 를 stack 에 추가.
        if (pivotIndex - 1) > start {
            stack.push(start)
            stack.push(pivotIndex - 1)
        }
        
        if (pivotIndex + 1) < end {
            stack.push(pivotIndex + 1)
            stack.push(end)
        }
    }
}

extension MutableCollection where Self: BidirectionalCollection, Element: Comparable {
    mutating func quicksort() {
        quicksortLomuto(low: startIndex, high: index(before: endIndex))
    }
    
    private mutating func quicksortLomuto(low: Index, high: Index) {
        if low <= high {
            let pivotValue = self[high]
            
            var p = self.partition { $0 > pivotValue }
            
            if p == endIndex {
                p = index(before: p)
            }
            
            self[..<p].quicksortLomuto(low: low, high: index(before: p))
            self[p...].quicksortLomuto(low: index(after: p), high: high)
        }
    }
}

/// Copied from DataStructure.playground
public struct Stack<Element> {
    private var storage: [Element] = []
    
    public init() { }
    
    public init(_ elements: Array<Element>) { // Element 를 보내주는대로 Compiler 가 타입을 추론한다.
        self.storage = elements
    }
    
    public mutating func push(_ element: Element) {
        storage.append(element) // append의 Complexity는 평균 O(1)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast() // popLast의 Complexity는 O(1)
    }
    
    public func peek() -> Element? {
        storage.last // last의 Complecxity는 O(1)
    }
    
    public var isEmpty: Bool {
        peek() == nil
    }
}

extension Stack: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        """
        ----top----
        \(storage.map { "\($0)" }.reversed().joined(separator: "\n"))
        -----------
        """
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

/// Key points
/// - stack은 LIFO, last-in-first-out 이다.
/// - 간단하지만 중요하다.
/// - push, pop 이라는 핵심 메소드가 있다.
