import Foundation

public func mergeSort<Element>(_ arr: [Element]) -> [Element] where Element: Comparable {
    guard arr.count > 1 else {
        return arr
    }
    
    let middle = arr.count / 2
    let left = mergeSort(Array(arr[..<middle]))
    let right = mergeSort(Array(arr[middle...]))
    return merge(left, right)
}

private func merge<Element>(_ left: [Element], _ right: [Element]) -> [Element] where Element: Comparable {
    var leftIndex = 0
    var rightIndex = 0
    
    var result: [Element] = []
    
    while leftIndex < left.count && rightIndex < right.count {
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]
        
        // 위에서 하나씩 꺼낸 뒤 순서에 따라 순차적으로 결과 배열에 삽입한다(Sorting).
        if leftElement < rightElement {
            result.append(leftElement)
            leftIndex += 1
        } else if leftElement > rightElement {
            result.append(rightElement)
            rightIndex += 1
        } else {
            result.append(leftElement)
            leftIndex += 1
            result.append(rightElement)
            rightIndex += 1
        }
    }
    
    if leftIndex < left.count {
        result.append(contentsOf: left[leftIndex...])
    }
    
    if rightIndex < right.count {
        result.append(contentsOf: right[rightIndex...])
    }
    
    return result
}
