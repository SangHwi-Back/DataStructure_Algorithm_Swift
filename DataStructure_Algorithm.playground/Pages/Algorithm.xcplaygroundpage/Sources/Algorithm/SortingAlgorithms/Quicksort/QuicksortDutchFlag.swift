import Foundation

public func partitionDutchFlag<T: Comparable>( _ a: inout [T], low: Int, high: Int, pivotIndex: Int) -> (Int, Int) {
    
    let pivot = a[pivotIndex]
    
    var smaller = low
    var equal = low
    var larger = high
    
    while equal <= larger {
        if a[equal] < pivot { // equal 아래의 모든 요소들은 pivot 보다 작을 것이다.
            a.swapAt(smaller, equal)
            smaller += 1
            equal += 1
        } else if a[equal] == pivot { // equal 아래의 모든 요소들은 pivot 보다 작거나 같을 것이다.
            equal += 1
        } else { // equal 보다 큰 요소는 모두 equal 위로 이동할 것이다.
            a.swapAt(equal, larger)
            larger -= 1
        }
    }
    
    return (smaller, larger)
}

public func quicksortDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let (middleFirst, middleLast) = partitionDutchFlag(&a, low: low, high: high, pivotIndex: high)
        quicksortDutchFlag(&a, low: low, high: middleFirst-1)
        quicksortDutchFlag(&a, low: middleLast+1, high: high)
    }
}
