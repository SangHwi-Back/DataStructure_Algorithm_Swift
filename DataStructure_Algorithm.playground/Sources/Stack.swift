import Foundation

public struct Stack<Element> {
    private var storage: [Element] = []
    
    public init() { }
    
    public mutating func push(_ element: Element) {
        storage.append(element) // append의 Complexity는 평균 O(1)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast() // popLast의 Complexity는 O(1)
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
