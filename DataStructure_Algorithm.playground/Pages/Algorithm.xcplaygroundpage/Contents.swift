import Foundation

let size = 1024
var values: [Int] = []
// 1
for i in 0 ..< size {
    values.append(i)
}

//var sizes = size
//var result = [0, size-1]
//result.reserveCapacity(1024)
//while result.count <= size {
//    result.insert((result.max() ?? 0)-result.count/2, at: result.count/2)
//    result.insert((result.min() ?? 0)+result.count/2, at: result.count/2)
//}

var array1 = [1, 2, 3, 4, 5, 6, 7, 8]
var array2 = [1, 3, 4, 5, 5, 6, 7, 7]

for element in merge(array1, array2) {
    print(element)
}

