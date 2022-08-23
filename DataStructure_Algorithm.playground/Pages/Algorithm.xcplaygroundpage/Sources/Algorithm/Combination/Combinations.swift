import Foundation

/// https://velog.io/@qwer15417/Swift-%EC%88%9C%EC%97%B4%EA%B3%BC-%EC%A1%B0%ED%95%A9

public func combination<T: Comparable>(_ arr: [T], _ count: Int) -> [[T]] {
    var result = [[T]]()
    if arr.count < count { return [arr] }
    
    var stack = arr.enumerated().map({ ([$0.element], $0.offset)})
    
    while stack.count > 0 {
        let now = stack.removeLast() // ([1], 0)
        
        let elements = now.0 // [1]
        let index = now.1 // 0
        
        if elements.count == count {
            result.append(elements.sorted())
            continue
        }
        
        guard index < arr.count-1 else { continue }
        
        for i in index ..< arr.count {
            if elements.contains(arr[i]) == false {
                stack.append(( elements+[arr[i]] , i ))
            }
        }
    }
    
    return result
}

public func combinationCycle<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    if array.count < n { return result }
    
    func cycle(_ index: Int, _ now: [T]) {
        if now.count == n {
            result.append(now)
            return
        }
        
        for i in index ..< array.count {
            cycle(i + 1, now + [array[i]])
        }
    }
    
    cycle(0, [])
    
    return result
}
