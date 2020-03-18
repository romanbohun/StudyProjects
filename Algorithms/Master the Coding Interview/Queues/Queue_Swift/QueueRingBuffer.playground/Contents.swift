public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    func peek() -> Element?
    var isEmpty: Bool { get }
}

public struct QueueRingBuffer<T>: Queue, CustomStringConvertible {
    
    public var isEmpty: Bool {
        return buffer.isEmpty
    }
    
    public var description: String {
        String(describing: buffer)
    }
    
    private var buffer: RingBuffer<T>
    
    init(_ count: Int) {
        buffer = RingBuffer<T>(count)
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        buffer.write(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        return buffer.read()
    }
    
    public func peek() -> T? {
        return buffer.first
    }
    
}

public struct RingBuffer<T>: CustomStringConvertible {
    
    private var array: [T?]
    private var writeIndex: Int = 0
    private var readIndex: Int = 0
    
    public var isFull: Bool {
        return array.count - (writeIndex - readIndex) == 0
    }
    
    public var isEmpty: Bool {
        return writeIndex - readIndex == 0
    }

    public var first: T? {
        return array[readIndex % array.count]
    }
    
    public var description: String {
        String(describing: array) + " " + String(writeIndex) + " " + String(readIndex)
    }
    
    init(_ count: Int) {
        array = [T?].init(repeating: nil, count: count)
    }
    
    public mutating func write(_ value: T) -> Bool {
        guard !isFull else {
            return false
        }
        array[writeIndex % array.count] = value
        writeIndex += 1
        return true
    }
    
    public mutating func read() -> T? {
        guard !isEmpty else {
            return nil
        }
        let element = array[readIndex % array.count]
        readIndex += 1
        return element
    }
    
}


var myQueue = QueueRingBuffer<Int>(4)
myQueue.enqueue(1)
myQueue.enqueue(2)
print(myQueue)
myQueue.enqueue(3)
myQueue.enqueue(4)
print(myQueue)
print(myQueue.dequeue())
print(myQueue.dequeue())
print(myQueue.dequeue())
print(myQueue.dequeue())
print(myQueue.dequeue())
