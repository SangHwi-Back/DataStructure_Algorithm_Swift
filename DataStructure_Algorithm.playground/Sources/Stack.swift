import Foundation

public struct Stack<Element> {
    private var storage: [Element] = []
    
    public init() { }
    
    public init(_ elements: Array<Element>) { // Element 를 보내주는대로 Compiler 가 타입을 추론한다.
        self.storage = elements
    }
    
    public mutating func push(_ element: Element) {
        storage.append(element) // append의 Complexity는 평균 O(1)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast() // popLast의 Complexity는 O(1)
    }
    
    public func peek() -> Element? {
        storage.last // last의 Complecxity는 O(1)
    }
    
    public var isEmpty: Bool {
        peek() == nil
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

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}
