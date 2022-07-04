import Foundation

// array를 반대로 만들고 출력하는 메소드를 만들어라.

func printInReverse<T>(_ array: [T]) {
    var stack = Stack<T>.init(array)
    
    while let lastElement = stack.pop() { // LIFO 이기 때문에 마지막 것만 가져올 것.
        print(lastElement)
    }
}

let array = [1.0, 2.0, 3.0, 4.0]

printInReverse(array)

// 괄호를 방향에 따라 나누었을 때 같은 수 인지 확인해보아라.

func isBalance(_ str: String) -> Bool {
    
    let parentheses = str.filter({$0 == "(" || $0 == ")"}) // O(n)
    var stringStack = Stack(parentheses.map{"\($0)"}) // O(n)
    
    var leftCount = 0
    var rightCount = 0
    
    while let lastElement = stringStack.pop() { // O(n)
        if lastElement == "(" {
            leftCount += 1
        } else {
            rightCount += 1
        }
    }
    
    return leftCount==rightCount
}

isBalance("h((e))llo(world)()")
isBalance("(hello world")
