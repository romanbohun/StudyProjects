public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    func peek() -> Element?
    var isEmpty: Bool { get }
}

public struct QueueStack<T>: Queue, CustomStringConvertible {
    private var leftStack: [T] = []
    private var rightStack: [T] = []
    
    public var isEmpty: Bool {
        return leftStack.isEmpty && rightStack.isEmpty
    }
    
    public var description: String {
        String(describing: leftStack.reversed() + rightStack)
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
    
    public func peek() -> T? {
        return !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
    
}

var myQueue = QueueStack<Int>()
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

