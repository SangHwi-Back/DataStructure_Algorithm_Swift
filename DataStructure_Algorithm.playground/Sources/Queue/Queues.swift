import Foundation

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

/**
 Queue를 만드는 방법
 1. 배열을 사용한다.
 2. 이중 연결 리스트를 사용한다.
 3. 링 버퍼를 사용한다.
 4. 두 개의 스택을 사용한다.
 */
