import Foundation

public class QueueLinkedList<T: Equatable>: DoublyQueue {
    private var list = DoublyLinkedList<T>()
    public init() { }
    
    /// O(1)
    public func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
    
    /// O(1)
    public func enqueue(_ element: T, direction: Direction = .back) -> Bool {
        switch direction {
        case .front:
            list.prepend(element)
        case .back:
            list.append(element)
        }
        return true
    }
    
    public func dequeue() -> T? {
        guard !list.isEmpty else {
            return nil
        }
        
        return list.pop()
    }
    
    public func dequeue(direction: Direction) -> T? {
        switch direction {
        case .front:
            return list.pop()
        case .back:
            return list.removeLast()
        }
    }
    
    public var peek: T? {
        list.first?.value
    }
    
    public var last: T? {
        list.last?.value
    }
    
    public var isEmpty: Bool {
        list.isEmpty
    }
    
    public func count() -> Int {
        list.count()
    }
}

extension QueueLinkedList: CustomStringConvertible {
    public var description: String {
        String(describing: list)
    }
}

/**
 |Operations|Average Case|Worst case|
 |---|---|---|
 |enqueue|O(1)|O(1)|
 |dequeue|O(1)|O(1)|
 |Space Complexity|O(n)|O(n)|
 */
