import Foundation


func getNthSmallestElement<Element: Comparable>(n: Int, elements: [Element]) -> Element? {
    var heap = Heap(sort: <, elements: elements)
    var current = 1
    while heap.isEmpty == false {
        let element = heap.remove() // Min Heap일 경우 root 는 반드시 가장 적은 값이므로, 가장 적은 값을 계속해서 추출한다.
        if current == n {
            return element
        }
        current += 1
    }
    
    return nil
}

func combineHeap<Element: Comparable & Equatable>(_ lh: Heap<Element>, _ rh: Heap<Element>) -> Heap<Element> {
    var lh = lh
    
    if let peekValue = lh.peek(), peekValue > lh.remove(at: lh.count-1)! { // Max Heap
        return Heap(sort: >, elements: lh.elements+rh.elements)
    } else {
        return Heap(sort: <, elements: lh.elements+rh.elements)
    }
}

//print(Heap(sort: <, elements: [21, 10, 18, 5, 3, 100, 1]))
let heap = combineHeap(Heap(sort: <, elements: [21, 10, 18, 5, 3, 100, 1]), Heap(sort: <, elements: [3, 10, 18, 5, 21, 100]))
print(heap)
