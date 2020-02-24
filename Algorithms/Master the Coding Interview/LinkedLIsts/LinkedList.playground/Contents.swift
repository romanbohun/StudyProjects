struct LinkedList<T>: CustomStringConvertible {
    
    private class node {
        
        let value: T
        var next: node?
        
        init(_ value: T, next: node? = nil) {
            self.value = value
            self.next = next
        }
        
    }
    
    private var head: node? = nil
    private var tail: node? = nil
    private var length: Int = 0
    
    var description: String {
        var array: [T] = []
        var currentNode: node? = self.head
        while let value = currentNode?.value {
            array.append(value)
            currentNode = currentNode?.next
        }
        
        return String(describing: array)
    }
    
    var isEmpty: Bool {
        return head == nil
    }
    
    init () {}
    
    mutating func append(_ value: T) {
        if isEmpty {
            push(value)
            return
        }
        
        let newNode = node(value)
        tail?.next = newNode
        tail = newNode
        length += 1;
    }
    
    mutating func push(_ value: T) {
        let newNode = node(value, next: head)
        head = newNode
        if tail == nil {
            tail = head
        }
        length += 1;
    }
    
    mutating func insert(_ value: T, at index: Int) {
        if index <= 0 {
            push(value)
            return
        } else if index > length {
            append(value)
            return
        }
        let leadNode = getNodeByIndex(index - 1)
        let newNode = node(value, next: leadNode?.next)
        leadNode?.next = newNode
        length += 1;
    }
        
    @discardableResult
    mutating func pop() -> T? {
        guard let result = head?.value else { return nil }
        head = head?.next
        if isEmpty {
            tail = nil
        }
        length -= 1;
        return result
    }
    
    @discardableResult
    mutating func removeLast() -> T? {
        guard head?.next != nil else {
            return pop()
        }
        return remove(at: length - 2)
    }
    
    @discardableResult
    mutating func remove(at index: Int) -> T? {
        guard index >= 0 && index <= length else {
            fatalError("Index is out of range")
        }
        if index == 0 {
            let removedValue = head?.value
            head = head?.next
            length -= 1;
            return removedValue
        }
        let leadNode = getNodeByIndex(index - 1)
        let removedNode = leadNode?.next
        leadNode?.next = removedNode?.next
        length -= 1;
        return removedNode?.value
    }

    func get(at index: Int) -> T? {
        guard index >= 0 && index <= length else {
            fatalError("Index is out of range")
        }
        let node = getNodeByIndex(index)
        return node?.value
    }
    
    mutating func reverse() {
        guard length > 1 else { return }
        var first = head
        tail = head
        var second = first?.next
        while second != nil {
            let temp = second?.next
            second?.next = first
            first = second
            second = temp
        }
        head?.next = nil
        head = first
    }
    
    private func getNodeByIndex(_ index: Int) -> node? {
        var currentIndex = 0
        var foundNode: node? = head
        while currentIndex != index {
            foundNode = foundNode?.next
            currentIndex += 1
        }
        return foundNode
    }
    
}

var linkedList = LinkedList<Int>()
linkedList.append(10)
linkedList.append(20)
linkedList.append(30)
linkedList.push(5)
linkedList.push(1)
linkedList.insert(7, at: 2)
linkedList.insert(15, at: 4)
linkedList.remove(at: 6)
//linkedList.reverse()
linkedList.pop()
linkedList.get(at: 3)
print(linkedList)
linkedList.removeLast()
print(linkedList)
