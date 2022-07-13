import Foundation

// 배열이 아니라 Stack 을 이용할 순 없나?
public struct QueueStack<T>: Queue {
    private var leftStack: [T] = []
    private var rightStack: [T] = []
    
    public init() { }
    
    public var isEmpty: Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }
    
    public var peek: T? {
        !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        
        return leftStack.popLast()
    }
}

extension QueueStack: CustomStringConvertible {
    public var description: String {
        String(describing: leftStack.reversed() + rightStack)
    }
}

/**
 |Operations|Average Case|Worst case|
 |---|---|---|
 |enqueue|O(1)|O(n)|
 |dequeue|O(1)|O(n)|
 |Space Complexity|O(n)|O(n)|
 */
