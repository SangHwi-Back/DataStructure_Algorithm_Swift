import Foundation

let charArray = ["A", "B", "C", "D"]
var stack = Stack<String>(charArray)

print(stack)
stack.pop()

var stackFromArray = Stack<Float>.init(arrayLiteral: 1.0, 2.0, 3.0, 4.0)
print(stackFromArray)
stackFromArray.pop()
