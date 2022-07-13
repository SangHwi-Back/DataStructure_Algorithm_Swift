import Foundation

public struct QueueRingBuffer<T>: Queue {
    
    private var ringBuffer: RingBuffer<T>
    
    public init(count: Int) {
        ringBuffer = RingBuffer<T>(count: count)
    }
    
    public var isEmpty: Bool {
        ringBuffer.isEmpty
    }
    
    public var peek: T? {
        ringBuffer.first
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        ringBuffer.write(element)
    }
    
    public mutating func dequeue() -> T? {
        ringBuffer.read()
    }
}

extension QueueRingBuffer: CustomStringConvertible {
    public var description: String {
        String(describing: ringBuffer)
    }
}

/**
 |Operations|Average Case|Worst case|
 |---|---|---|
 |enqueue|O(1)|O(1)|
 |dequeue|O(1)|O(1)|
 |Space Complexity|O(n)|O(n)|
 */
