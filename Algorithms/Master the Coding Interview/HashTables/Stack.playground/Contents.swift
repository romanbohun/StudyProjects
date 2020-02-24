
import Foundation

public struct Stack<Element> {
    
    private var storage: [Element] = []
    
    public init() { }
    
    public init(_ elements: [Element]) {
        storage = elements
    }
    
    public var isEmpty: Bool {
        return peek() == nil
    }
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        return storage.popLast()
    }
    
    public func peek() -> Element? {
        return storage.last
    }
    
}

extension Stack: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
    
}

extension Stack : CustomStringConvertible {
    
    public var description: String {
        """
        ----top----
        \(storage.map { "\($0)" }.reversed().joined(separator: "\n" ))
        -----------
        """
    }
    
}


func example1 () {
    var stack = Stack<Int>()
    stack.push(1)
    stack.push(2)
    stack.push(3)
    stack.push(4)
    
    print(stack)
    
    if let poppedElement = stack.pop() {
        assert(4 == poppedElement)
        print("Popped: \(poppedElement)")
    }
}

func example2() {
    let array = ["A", "B", "C", "D"]
    var stack = Stack(array)
    print(stack)
    stack.pop()
}

func example3() {
    var stack: Stack = [1, 2, 3, 4, 5]
    print(stack)
    stack.pop()
}


//Challenge1: Reverse an Array
func reverseArray<T>(_ array: [T]) -> [T] {
//    let methodStart = Date()
    var stack = Stack<T>()
    for item in array {
        stack.push(item)
    }
    
    var resultArray: [T] = []
    while let value = stack.pop() {
        resultArray.append(value)
    }
//    let methodFinish = Date()
//    print(methodFinish.timeIntervalSince(methodStart))
    return resultArray
}

func reverseArray2<T>(_ array: [T]) -> [T?] {
//    let methodStart = Date()
    var resultArray: [T?] = Array(repeating: nil, count: array.endIndex + 1)
    for (index, item) in array.enumerated() {
        resultArray[array.endIndex - index] = item
    }
//    let methodFinish = Date()
//    print(methodFinish.timeIntervalSince(methodStart))
    return resultArray
}

//reverseArray([1, 2, 3, 4, 5])
//reverseArray2([1, 2, 3, 4, 5])

//Challenge2: Balance the parentheses
func checkParentheses(_ string: String) -> Bool {
    var stack = Stack<Character>()
    for character in string {
        if character == "(" {
            stack.push(character)
        } else if character == ")" {
            if stack.isEmpty {
                return false
            } else {
                stack.pop()
            }
        }
    }
    return stack.isEmpty
}

checkParentheses("h((e))llo(world)()")
