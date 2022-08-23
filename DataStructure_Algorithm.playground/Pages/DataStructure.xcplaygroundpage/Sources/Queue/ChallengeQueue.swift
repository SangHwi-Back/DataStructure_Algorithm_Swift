import Foundation

/// #3 Whose turn it is?
protocol BoardGameManager {
    associatedtype Player
    mutating func nextPlayer() -> Player?
}

struct GameQueueRingBuffer<T: CustomStringConvertible>: BoardGameManager {
    private var ringBuffer: QueueRingBuffer<T>
    
    init(count: Int) {
        self.ringBuffer = QueueRingBuffer<T>(count: count)
    }
    
    mutating func nextPlayer() -> T? {
        guard let player = ringBuffer.dequeue() else {
            return nil
        }
        
        ringBuffer.enqueue(player)
        
        return player
    }
    
    mutating func enqueue(_ player: T) {
        ringBuffer.enqueue(player)
    }
}

public func printPlayer() {
    var game = GameQueueRingBuffer<String>(count: 5)
    game.enqueue("Jack")
    game.enqueue("Mary")
    game.enqueue("Ellie")
    game.enqueue("Martin")
    game.enqueue("Goose")
    
    for _ in 0..<25 {
        if let player = game.nextPlayer() {
            print(player)
        }
    }
}

/// #4 Reverse Queue
extension QueueArray {
    public func reversed() -> QueueArray {
        var queue = self
        
        var stack = Stack<T>()
        
        while let element = queue.dequeue() {
            stack.push(element)
        }
        
        while let element = stack.pop() {
            queue.enqueue(element)
        }
        
        return queue
    }
}

// 이중 큐 자료구조를 만들어줌
public protocol Deque {
    associatedtype Element
    var isEmpty: Bool { get }
    func peek(from direction: Direction) -> Element?
    mutating func enqueue(_ element: Element, to direction: Direction) -> Bool
    mutating func dequeue(from direction: Direction) -> Element?
}

// 맨 앞 혹은 뒤에 요소를 넣을건지 뺄지 정한다.
public enum Direction {
    case front
    case back
}

/// #5 Double-ended Queue
public class DoubleQueueLinkedList<T: CustomStringConvertible & Equatable>: Deque {
    
    private var queueLinkedList: DoublyLinkedList<T>
    
    public var isEmpty: Bool {
        queueLinkedList.isEmpty
    }
    
    public init() {
        self.queueLinkedList = DoublyLinkedList<T>()
    }
    
    public func peek(from direction: Direction) -> T? {
        switch direction {
        case .front:
            return queueLinkedList.first?.value
        case .back:
            return queueLinkedList.last?.value
        }
    }
    
    public func enqueue(_ element: T, to direction: Direction) -> Bool {
        switch direction {
        case .front:
            queueLinkedList.prepend(element)
        case .back:
            queueLinkedList.append(element)
        }
        return true
    }
    
    public func dequeue(from direction: Direction) -> T? {
        var value: T?
        switch direction {
        case .front:
            guard let first = queueLinkedList.first else { return nil }
            value = first.value
        case .back:
            guard let last = queueLinkedList.last else { return nil }
            value = last.value
        }
        return value
    }
}

extension DoubleQueueLinkedList: CustomStringConvertible {
    public var description: String {
        String(describing: queueLinkedList)
    }
}
