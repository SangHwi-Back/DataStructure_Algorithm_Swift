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
