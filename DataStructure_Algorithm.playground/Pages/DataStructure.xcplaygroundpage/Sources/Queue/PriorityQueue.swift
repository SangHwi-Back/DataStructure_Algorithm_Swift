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
