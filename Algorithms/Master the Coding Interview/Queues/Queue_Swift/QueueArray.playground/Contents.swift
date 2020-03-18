public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    func peek() -> Element?
    var isEmpty: Bool { get }
}

public struct QueueArray<T>: Queue, CustomStringConvertible {
    
    public var isEmpty: Bool {
        return storage.isEmpty
    }
    
    public var description: String {
        String(describing: storage)
    }
    
    private var storage: [T] = []
    
    public mutating func enqueue(_ element: T) -> Bool {
        storage.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        guard !isEmpty else {
            return nil
        }
        return storage.removeFirst()
    }
    
    public func peek() -> T? {
        return storage.first
    }
    
}

var myQueue = QueueArray<Int>()
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
