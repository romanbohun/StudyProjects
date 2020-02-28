import Foundation

struct LinkedList<T>: CustomStringConvertible where T: Equatable {
    
    internal class node<T> {
        
        let value: T
        var next: node?
        
        init(_ value: T, next: node? = nil) {
            self.value = value
            self.next = next
        }
        
    }
    
    private(set) var head: node<T>? = nil
    private(set) var tail: node<T>? = nil
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
    
    init(_ head: node<T>, _ tail: node<T>) {
        self.head = head
        self.tail = tail
    }
    
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
    
    private func getNodeByIndex(_ index: Int) -> node<T>? {
        var currentIndex = 0
        var foundNode: node? = head
        while currentIndex != index {
            foundNode = foundNode?.next
            currentIndex += 1
        }
        return foundNode
    }
    
}

// This solution is good
// but the best one is to use DoublyLinkedList
// that provides prev property to move backward
extension LinkedList {
    
    func printInReverse() {
        printInReverse(self.head)
    }
    
    private func printInReverse(_ node: node<T>?) {
        guard let node = node else { return }
        printInReverse(node.next)
        print(node.value)
    }
}

extension LinkedList {
    
    func getMiddle() -> T? {
        var slow = head
        var fast = head
        
        while let nextFast = fast?.next {
            fast = nextFast.next
            slow = slow?.next
            print("----FAST---", fast?.value)
            print("----SLOW---", slow?.value)
        }
        return slow?.value
    }
    
    func getMiddle2() -> T? {
        let index = length/2
        return get(at: index)
    }
    
}

extension LinkedList {
    
    func removeAll(of value: T) {
        while let node = head, node.value == value {
            head = node.next
        }
            
        var prev = head
        var current = head?.next
        
        while let currentNode = current {
            guard currentNode.value != value else {
                prev?.next = currentNode.next
                current = currentNode.next
                continue
            }
            prev = current
            current = current?.next
        }
        tail = prev
    }
    
}

func mergeLinkedLists<T>(_ leftList: LinkedList<T>, _ rightList: LinkedList<T>) -> LinkedList<T>? where T: Comparable {
    guard !leftList.isEmpty else { return rightList }
    guard !rightList.isEmpty else { return leftList }
    
    var newHead: LinkedList<T>.node<T>?
    var newTail: LinkedList<T>.node<T>?
    var currentLeft = leftList.head
    var currentRight = rightList.head
    
    if let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.value < rightNode.value {
            newHead = leftNode
            currentLeft = leftNode.next
        } else {
            newHead = rightNode
            currentRight = rightNode.next
        }
        newTail = newHead
    }
    
    while let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.value < rightNode.value {
            newTail?.next = leftNode
            currentLeft = leftNode.next
        } else {
            newTail?.next = rightNode
            currentRight = rightNode.next
        }
        newTail = newTail?.next
    }
    
    if let leftNode = currentLeft {
        newTail?.next = leftNode
    } else if let rightNode = currentRight {
        newTail?.next = rightNode
    }
    
    if let head = newHead, let tail = newTail {
        return LinkedList<T>(head, tail)
    }
    
    return nil
}

var linkedList = LinkedList<Int>()
linkedList.append(10)
linkedList.append(20)
linkedList.append(30)
linkedList.append(40)
linkedList.append(50)
linkedList.append(60)
linkedList.append(70)

var linkedList2 = LinkedList<Int>()
linkedList2.append(11)
linkedList2.append(21)
linkedList2.append(31)
linkedList2.append(41)

print(mergeLinkedLists(linkedList, linkedList2))

//linkedList.push(5)
//linkedList.push(1)
//linkedList.insert(7, at: 2)
//linkedList.insert(15, at: 4)
//linkedList.remove(at: 6)
////linkedList.reverse()
//linkedList.pop()
//linkedList.get(at: 3)
//print(linkedList)
//linkedList.removeLast()
//print(linkedList)

//linkedList.printInReverse()
//let startTime1 = CFAbsoluteTimeGetCurrent()
//print(linkedList.getMiddle())
//let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime1
//print("TIME->", timeElapsed)
//let startTime2 = CFAbsoluteTimeGetCurrent()
//print(linkedList.getMiddle2())
//let timeElapsed2 = CFAbsoluteTimeGetCurrent() - startTime2
//print("TIME->", timeElapsed2)
