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

var buffer = RingBuffer<Int>(4)
print(buffer.write(1))
print(buffer.write(2))
print(buffer.read())
print(buffer)
print(buffer.write(3))
print(buffer.write(4))
print(buffer)
print(buffer.write(5))
print(buffer)
print(buffer.read())
print(buffer.read())
print(buffer.read())
print(buffer)
print(buffer.read())
print(buffer.read())
print(buffer)
print(buffer.write(5))
print(buffer)
