import Foundation

/**
 * Reference from Swift-Algorithm-Club
 */

func factorial(_ n: Int) -> Int {
    var n = n
    var result = 1
    
    while n > 1 {
        result *= n
        n -= 1
    }
    
    return result
}

/// 순열 P(n, k)
public func permutations(_ n: Int, _ k: Int) -> Int {
    var n = n
    var answer = n
    
    for _ in 1..<k {
        n -= 1
        answer *= n
    }
    
    return answer
}

/// 주어진 배열의 순열을 출력한다.
public func permuteWirth<T>(_ a: [T], _ n: Int) {
    if n == 0 {
        print(a)
    } else {
        var a = a
        
        // swap 하기 전의 배열을 반환하기 위해 그대로 dynamic 호출.
        // 사실 상 n-1을 반복하기 때문에 이 배열이 위의 n==0 조건에 충족하게 될 것이다.
        permuteWirth(a, n-1)
        
        for i in 0..<n {
            // 이미 n 위치는 한번 바꾸었으므로, n 앞의 위치를 0부터 차례로 바꾼 후 반영하도록 한다.
            a.swapAt(i, n)
            permuteWirth(a, n-1)
            a.swapAt(i, n)
        }
    }
}

/// 주어진 배열의 순열을 출력한다.
public func permuteWirth2<T>(_ a: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    
    func permute(_ a: [T], _ n: Int) {
        if n == 0 {
            result.append(a)
        } else {
            var a = a
            permute(a, n-1)
            
            for i in 0..<n {
                a.swapAt(i, n)
                permute(a, n-1)
                a.swapAt(i, n)
            }
        }
    }
    
    permute(a, n)
    
    return result
}
