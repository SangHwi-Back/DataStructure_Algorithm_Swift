import Foundation

var array = [6,12,2,26,8,18,21,9,5]

print(Heap(sort: >, elements: array))

print(array)
print(array.makeHeapSort())
array.heapSort()
print(array)
