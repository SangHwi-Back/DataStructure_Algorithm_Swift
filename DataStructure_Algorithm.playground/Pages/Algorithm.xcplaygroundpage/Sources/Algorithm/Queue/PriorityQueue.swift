import Foundation

public struct PriorityQueue<Element: Equatable>: Queue {
    
    private var heap: Heap<Element>
    
    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) { // sort 에 의해 Max/Min Priority Queue 를 만들 수 있다.
        heap = Heap(sort: sort, elements: elements)
    }
    
    public var isEmpty: Bool {
        heap.isEmpty
    }
    
    public var peek: Element? {
        heap.peek()
    }
    
    @discardableResult
    mutating public func enqueue(_ element: Element) -> Bool { // enqueue 와 동시에 sift-up 을 이용해서 자동 validation ( O(log n) )
        heap.insert(element)
        return true
    }
    
    mutating public func dequeue() -> Element? {
        heap.remove()
    }
}

public struct PriorityQueueArray<Element: Comparable>: Queue {
    
    private var elements: [Element] = []
    let sort: (Element, Element) -> Bool
    
    public init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        self.elements.sort(by: sort)
    }
    
    public var peek: Element? {
        elements.first
    }
    
    public var isEmpty: Bool {
        elements.isEmpty
    }
    
    public mutating func enqueue(_ element: Element) -> Bool {
        for (index, item) in elements.enumerated() {
            if sort(element, item) {
                elements.insert(element, at: index)
                return true
            }
        }
        
        elements.append(element)
        return true
    }
    
    public mutating func dequeue() -> Element? {
        elements.removeFirst()
    }
}

extension PriorityQueueArray: CustomStringConvertible {
    public var description: String {
        String(describing: elements)
    }
}
