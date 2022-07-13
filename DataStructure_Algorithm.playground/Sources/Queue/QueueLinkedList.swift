import Foundation

public class QueueLinkedList<T: Equatable>: Queue {
    private var list = DoublyLinkedList<T>()
    public init() { }
    
    /// O(1)
    public func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
    
    public func dequeue() -> T? {
        guard !list.isEmpty else {
            return nil
        }
        
        return list.pop()
    }
    
    public var peek: T? {
        list.head?.value
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
