import Foundation

//printPlayer()
var queueArr = QueueLinkedList<String>()

queueArr.enqueue("1")
queueArr.enqueue("2")
queueArr.enqueue("3")
queueArr.enqueue("4")
queueArr.enqueue("5")

print(queueArr)
//print(queueArr.reversed())

var queueDouble1 = DoubleQueueLinkedList<String>()

queueDouble1.enqueue("5", to: .front)
queueDouble1.enqueue("4", to: .front)
queueDouble1.enqueue("3", to: .front)
queueDouble1.enqueue("2", to: .front)
queueDouble1.enqueue("1", to: .front)

var queueDouble2 = DoubleQueueLinkedList<String>()

queueDouble2.enqueue("1", to: .back)
queueDouble2.enqueue("2", to: .back)
queueDouble2.enqueue("3", to: .back)
queueDouble2.enqueue("4", to: .back)
queueDouble2.enqueue("5", to: .back)

print(queueDouble1)
print(queueDouble2)
