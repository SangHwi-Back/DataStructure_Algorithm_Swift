import Foundation

/**
 read, write 포인터를 둔다. 처음에는 둘 다 같은 Index에 위치한다. 버퍼의 크기는 정해져 있다.
 enqueue 하면 wrtie 포인터가 enqueue 한 만큼 이동한다.
 dequeue 하면 read 포인터가 dequeue 한 만큼 이동한다.
 정해진 버퍼 크기 만큼 enqueue 하면 write 포인터가 원점으로 돌아간다.
 정해진 버퍼 크기 만큼 dequeue 하면 read 포인터가 원점으로 돌아간다.
 */

public struct RingBuffer<T> {
    private var array: [T?]
    private var readIndex = 0
    private var writeIndex = 0
    
    public init(count: Int) {
        array = Array<T?>(repeating: nil, count: count)
    }
    
    public var first: T? {
        array[readIndex]
    }
    
    public mutating func write(_ element: T) -> Bool {
        if !isFull {
            array[writeIndex % array.count] = element
            writeIndex += 1
            return true
        } else {
            return false
        }
    }
    
    public mutating func read() -> T? {
        if !isEmpty {
            let element = array[readIndex % array.count]
            readIndex += 1
            return element
        } else {
            return nil
        }
    }
    
    private var availableSpaceForReading: Int {
        writeIndex - readIndex
    }
    
    public var isEmpty: Bool {
        availableSpaceForReading == 0
    }
    
    private var availableSpaceForWriting: Int {
        array.count - availableSpaceForReading
    }
    
    public var isFull: Bool {
        availableSpaceForWriting == 0
    }
}

extension RingBuffer: CustomStringConvertible {
    public var description: String {
        let values = (0..<availableSpaceForReading).map {
            String(describing: array[($0 + readIndex) % array.count]!)
        }
        
        return "[" + values.joined(separator: ", ") + "]"
    }
}
