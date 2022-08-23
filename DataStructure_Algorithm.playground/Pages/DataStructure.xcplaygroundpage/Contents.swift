import Foundation

//var priorityQueue = PriorityQueue(sort: >, elements: [1,12,3,4,1,6,8,7]) // Max Priority Queue
//var priorityQueueArray = PriorityQueueArray(sort: >, elements: [1,12,3,4,1,6,8,7]) // Max Priority Queue
//priorityQueueArray.enqueue(5)
//priorityQueueArray.enqueue(0)
//priorityQueueArray.enqueue(10)
//while !priorityQueue.isEmpty {
//    print(priorityQueue.dequeue() ?? -1)
//}
//print("-------------------------------")
//while !priorityQueueArray.isEmpty {
//    print(priorityQueueArray.dequeue() ?? -1)
//}

public struct Person: Equatable {
  let name: String
  let age: Int
  let isMilitary: Bool
}

var waitlistQueue = PriorityQueue(sort: { lh, rh in
    if lh.isMilitary && rh.isMilitary {
        return lh.age > rh.age
    }
    
    return lh.isMilitary
}, elements: [
    Person(name: "A", age: 1, isMilitary: false),
    Person(name: "B", age: 1, isMilitary: false),
    Person(name: "C", age: 1, isMilitary: true),
    Person(name: "D", age: 1, isMilitary: false),
    Person(name: "E", age: 1, isMilitary: true),
    Person(name: "F", age: 1, isMilitary: true),
    Person(name: "G", age: 1, isMilitary: false),
    Person(name: "H", age: 1, isMilitary: false),
])

while !waitlistQueue.isEmpty {
    print(waitlistQueue.dequeue())
}
