import Foundation

extension Array where Element == Int {
    public mutating func radixSort() {
        let base = 10
        var done = false
        var digits = 1
        
        while !done {
            
            done = true
            
            var buckets: [[Int]] = .init(repeating: [], count: base)
            
            forEach { number in
                
                let remainingPart: Int = number / digits
                let digit = remainingPart % base
                
                buckets[digit].append(number)
                
                if remainingPart > 0 {
                    done = false
                }
            }
            
            digits *= base
            self = buckets.flatMap({ $0 })
        }
    }
    
    public func lexicographicalSort() -> [String] {
        var done = false
        var index = 0
        
        var result = [String]()
        
        while !done {
            
            done = true
//            var buckets = Array<Array<String>>(repeating: [], count: 28+10+1) // 알파벳 갯수, 십진수 갯수, 빈칸
            var buckets = [String: Array<String>]()
            
            forEach {
                let element = String($0)
                let item = element.count >= index ? String(element[element.index(element.startIndex, offsetBy: index)]) : ""
                
                buckets[item] = (buckets[item] ?? []) + [element]
                
                if element.count + 1 == index {
                    done = false
                }
            }
            
            index += 1
//            self = buckets.flatMap({$0})
            result = buckets.sorted(by: { $0.key.count < $1.key.count && $0.key < $1.key }).map({$0.value}).flatMap({$0})
        }
        
        return result
    }
}
