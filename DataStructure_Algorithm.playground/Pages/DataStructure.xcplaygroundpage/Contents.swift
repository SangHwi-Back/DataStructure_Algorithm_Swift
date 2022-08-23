import Foundation

var priorityQueue = PriorityQueue(sort: >, elements: [1,12,3,4,1,6,8,7]) // Max Priority Queue

while !priorityQueue.isEmpty {
    print(priorityQueue.dequeue())
}
