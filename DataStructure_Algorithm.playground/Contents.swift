import Foundation

var queueArray = QueueArray<String>()

queueArray.enqueue("Ray")
queueArray.enqueue("Brian")
queueArray.enqueue("Eric")
print(queueArray)
queueArray.dequeue()
print(queueArray)
print(queueArray.peek!)

print("-------")

var queueLinkedList = QueueLinkedList<String>()

queueLinkedList.enqueue("Ray")
queueLinkedList.enqueue("Brian")
queueLinkedList.enqueue("Eric")
print(queueLinkedList)
print(queueLinkedList.dequeue()!)
print(queueLinkedList.count())
print(queueLinkedList)
