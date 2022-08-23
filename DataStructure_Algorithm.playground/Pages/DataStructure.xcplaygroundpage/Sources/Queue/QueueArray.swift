import Foundation

public struct QueueArray<T>: Queue { // 컴파일러가 T를 Element로 타입추론한다.
    private var array: [T] = []
    public init() { }
    
    /// O(1)
    public var isEmpty: Bool {
        array.isEmpty
    }
    
    /// O(1)
    public var peek: T? {
        array.first
    }
    
    /// O(1) - If memory allocated for array is full, O(n).
    @discardableResult
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    /// O(n) - all elements shifted in memory
    public mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        String(describing: array)
    }
}

/**
 |Operations|Average Case|Worst case|
 |---|---|---|
 |enqueue|O(1)|O(n)|
 |dequeue|O(n)|O(n)|
 |Space Complexity|O(n)|O(n)|
 */
