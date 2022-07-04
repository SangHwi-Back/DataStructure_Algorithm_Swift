import Foundation

// array를 반대로 만들고 출력하는 메소드를 만들어라.

func printInReverse<T>(_ array: [T]) {
    // 이 방법은 reversed() 를 사용하기 때문에 O(n)을 두 번 반복한다.
//    var stack = Stack<T>.init(array)
//
//    while let lastElement = stack.pop() { // LIFO 이기 때문에 마지막 것만 가져올 것.
//        print(lastElement)
//    }
    var stack = Stack<T>()
    
    for element in array {
        stack.push(element)
    }
    
    while let lastElement = stack.pop() {
        print(lastElement)
    }
}

// 괄호를 방향에 따라 나누었을 때 같은 수 인지 확인해보아라.

func isBalance(_ str: String) -> Bool {
    // 이 방법은 O(n) 이 세 번 반복된다. 한번으로도 족하다.
//    let parentheses = str.filter({$0 == "(" || $0 == ")"}) // O(n)
//    var stringStack = Stack(parentheses.map{"\($0)"}) // O(n)
//
//    var leftCount = 0
//    var rightCount = 0
//
//    while let lastElement = stringStack.pop() { // O(n)
//        if lastElement == "(" {
//            leftCount += 1
//        } else {
//            rightCount += 1
//        }
//    }
//
//    return leftCount==rightCount
    
    var stack = Stack<Character>()
    
    for char in str { // O(n)
        if char == "(" {
            stack.push(char)
        } else if char == ")" {
            if stack.isEmpty {
                return false
            } else {
                stack.pop()
            }
        }
    }
    
    return stack.isEmpty
}
