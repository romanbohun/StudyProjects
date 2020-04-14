import Foundation
//Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
//
//push(x) -- Push element x onto stack.
//pop() -- Removes the element on top of the stack.
//top() -- Get the top element.
//getMin() -- Retrieve the minimum element in the stack.
//
///Example:
///
///MinStack minStack = new MinStack();
///minStack.push(-2);
///minStack.push(0);
///minStack.push(-3);
///minStack.getMin();   --> Returns -3.
///minStack.pop();
///minStack.top();      --> Returns 0.
///minStack.getMin();   --> Returns -2.

// Runtime 96 ms
class MinStack1 {

    private var stack: [Int]
    private var min: Int

    /** initialize your data structure here. */
    init() {
        stack = [Int]()
        min = Int.max
    }

    func push(_ x: Int) {
        stack.append(x)
        if x < min {
            min = x
        }
    }

    func pop() {
        let last = stack.removeLast()
        if last == min {
            min = Int.max
            for item in stack {
                if item < min {
                    min = item
                }
            }
        }
    }

    func top() -> Int {
        return stack.last ?? 0
    }

    func getMin() -> Int {
        return min
    }

}
