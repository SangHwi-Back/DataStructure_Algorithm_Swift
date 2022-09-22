import Foundation

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

public protocol DoublyQueue: Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element, direction: Direction) -> Bool
    mutating func dequeue(direction: Direction) -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

public enum Direction {
    case front
    case back
}
