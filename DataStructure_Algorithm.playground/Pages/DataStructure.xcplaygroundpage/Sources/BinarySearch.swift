import Foundation

public extension RandomAccessCollection where Element: Comparable {
    
    /// 조건 : Binary Search 에 이용되는 배열은 오름차순 정렬되어 있어야 한다.
    ///
    /// 탐색 방법
    /// 1. 중간 위치(Index)를 찾는다.
    /// 2. 중간 위치의 요소를 검사한다.
    /// 2-1. 중간 위치의 요소보다 크다면 중간 기준 오른쪽의 배열만을 가지고 다시 탐색한다.
    /// 2-2. 중간 위치의 요소보다 작다면 중간 기준 왼쪽의 배열만을 가지고 다시 탐색한다.
    /// 2-3. 중간 위치의 요소가 탐색하려는 요소와 같다면 위치나 요소를 반환한다.
    /// 3. 1과 2의 과정을 반복한다.
    func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
        
        if range == nil {
            let sorted = self.sorted()
            
            for index in sorted.indices {
                if self[index as! Self.Index] != sorted[index] {
                    return nil
                }
            }
        }
        
        let range = range ?? startIndex..<endIndex
        
        guard range.lowerBound < range.upperBound else {
            return nil
        }
        
        let size = distance(from: range.lowerBound, to: range.upperBound)
        let middle = index(range.lowerBound, offsetBy: size / 2)
        
        if self[middle] == value {
            return middle
        }
        else if self[middle] > value {
            return binarySearch(for: value, in: range.lowerBound..<middle)
        }
        else {
            return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
        }
    }
    
    func binarySearch<Elements: RandomAccessCollection>(for element: Elements.Element, in collection: Elements, in range: Range<Elements.Index>? = nil) -> Elements.Index? where Elements.Element: Comparable {
        
        let range = range ?? collection.startIndex ..< collection.endIndex
        
        guard range.lowerBound < range.upperBound else {
            return nil
        }
        
        let size = collection.distance(from: range.lowerBound, to: range.upperBound)
        let middle = collection.index(range.lowerBound, offsetBy: size / 2)
        
        if collection[middle] == element {
            return middle
        } else if collection[middle] > element {
            return binarySearch(for: element, in: collection, in: range.lowerBound..<middle)
        } else {
            return binarySearch(for: element, in: collection, in: collection.index(after: middle)..<range.upperBound)
        }
    }
}

public func findIndices(of value: Int, in array: [Int]) -> Range<Int>? {
    guard let startIndex = startIndex(of: value, in: array, range: 0..<array.count) else {
        return nil
    }
    
    guard let endIndex = endIndex(of: value, in: array, range: 0..<array.count) else {
        return nil
    }
    
    return startIndex..<endIndex
}

func startIndex(of value: Int, in array: [Int], range: CountableRange<Int>) -> Int? {
    let middleIndex = range.lowerBound + (range.upperBound-range.lowerBound) / 2
    
    if middleIndex == 0 || middleIndex == array.count-1 { // 중간 인덱스가 시작 인덱스 혹은 끝 인덱스인 경우
        if array[middleIndex] == value {
            return middleIndex
        }
        else {
            return nil
        }
    }
    
    if array[middleIndex] == value {
        if array[middleIndex - 1] != value {
            return middleIndex
        }
        else {
            return startIndex(of: value, in: array, range: range.lowerBound..<middleIndex) // 값은 일치하는데 중간 인덱스 이전 인덱스의 값도 일치하는 경우
        }
    }
    else if value < array[middleIndex] {
        return startIndex(of: value, in: array, range: range.lowerBound..<middleIndex)
    }
    else {
        return startIndex(of: value, in: array, range: middleIndex..<range.upperBound)
    }
}

func endIndex(of value: Int, in array: [Int], range: CountableRange<Int>) -> Int? {
    let middleIndex = range.lowerBound + (range.upperBound-range.lowerBound) / 2
    
    if middleIndex == 0 || middleIndex == array.count-1 {
        if array[middleIndex] == value {
            return middleIndex
        }
        else {
            return nil
        }
    }
    
    if array[middleIndex] == value {
        if array[middleIndex + 1] != value {
            return middleIndex + 1
        }
        else {
            return endIndex(of: value, in: array, range: middleIndex..<range.upperBound) // 값은 일치하는데 중간 인덱스 다음 인덱스의 값도 일치하는 경우
        }
    }
    else if value < array[middleIndex] {
        return endIndex(of: value, in: array, range: range.lowerBound..<middleIndex)
    }
    else {
        return endIndex(of: value, in: array, range: middleIndex..<range.upperBound)
    }
}
