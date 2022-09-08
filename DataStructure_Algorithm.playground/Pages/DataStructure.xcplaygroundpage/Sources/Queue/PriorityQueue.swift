import Foundation

/**
 * 기존의 Queue는 FIFO에 따라 순서에 따른 처리(값 방출)를 하였지만,
 * Priority Queue는 우선순위에 따라 처리를 한다.
 *
 * 우선순위는 Max-priority(가장 큰 값이 가장 먼저 처리/방출), Min-priority(가장 작은 값이 가장 먼저 처리/방출) 로 나뉜다.
 *
 * **Priority Queue 는 주어진 배열의 가장 큰/작은 값을 알아보고 싶을 때 유용하다.**
 *
 * 구체적인 사용예시는 다음과 같다.
 * 1. Dijkstra's algorithm : 최소값 계산
 * 2. A<*> pathfinding algorithm : 최단거리 계산
 * 3. Heap sort
 * 4. Huffman coding : 압축 트리를 생성한다. 최소 우선순위 큐가 부모 노드가 없는 가장 작은 두 개의 노드를 찾아준다.
 *
 * Priority Queue 구현할 때 사용할 수 있는 자료구조들
 * 1. Sorted array : enqueue 할 때마다 고려하여 실행하도록 한다.
 * 2. Balanced binary search tree : 양방향 우선순위 큐 구현에 유리함.
 * 3. Heap : 가장 많이 사용되는 자료구조. 부분적으로만 정렬되어도 충분하기 때문에 시간복잡도 이득.
 */

/*
 * 우선순위 Queue는 배열, 연결리스트, 힙 으로 구현이 가능하다.
 * 1. 배열로 구현한다고 가정하고, 우선순위가 높은 순서대로 배열의 가장 앞부분부터 넣는다면 맨 앞의 인덱스부터 차례로 방출하면 된다.
 *    하지만 우선순위 중간 범위의 데이터 삽입이 필요한 경우는 특정 인덱스 뒤의 요소들을 모두 한 칸씩 뒤로 밀어야 된다.
 *    시간복잡도는 삭제 시 O(1), 삽입 시 O(n).
 * 2. 연결리스트로 구현한다고 가정하고, 우선순위가 높은 순서대로 노드를 연결시킨다면 루트 노드부터 차례로 방출하면 된다.
 *    하지만 위와 같이 모든 요소가 뒤로 밀려야 하는 경우가 있어서 시간복잡도는 삭제 시 O(1), 삽입 시 O(n).
 * 3. 힙의 경우 level 1 당 저장 가능한 자료 갯수는 2배, 비교 연산 회수는 1회 증가한다.
 *    삭제/삽입 모두 O(log2n) 의 시간복잡도를 갖는다.
 *    시간복잡도 측면에서 삭제는 배열/연결리스트가 더 좋지만 삽입의 경우 힙이 좋다.
 * 주로, 편차가 심한 배열과 연결리스트 보다는 힙으로 구현한다.
 * [출처](https://chanhuiseok.github.io/posts/ds-4/)
 */

/// Heap 으로 구현한 Priority Queue
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
