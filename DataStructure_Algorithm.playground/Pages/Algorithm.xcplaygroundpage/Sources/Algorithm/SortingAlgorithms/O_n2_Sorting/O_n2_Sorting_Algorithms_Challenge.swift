import Foundation

// 1.
extension MutableCollection where Self: BidirectionalCollection, Element: Equatable {
    mutating func rightAligne(value: Element) {
        var left = startIndex
        var right = index(before: endIndex)
        
        while left < right {
            while self[right] == value {
                formIndex(before: &right)
            }
            while self[left] != value {
                formIndex(after: &left)
            }
            guard left < right else {
                return
            }
            
            swapAt(left, right)
        }
    }
}

extension Sequence where Element: Hashable {
    var firstDuplicate: Element? {
        var found: Set<Element> = []
        for value in self {
            if found.contains(value) {
                return value
            } else {
                found.insert(value)
            }
        }
        
        return nil
    }
}

extension MutableCollection where Self: BidirectionalCollection {
    mutating func reverse() {
        var left = startIndex
        var right = index(before: endIndex)
        
        while left < right {
            swapAt(left, right)
            formIndex(after: &left)
            formIndex(before: &right)
        }
    }
}
