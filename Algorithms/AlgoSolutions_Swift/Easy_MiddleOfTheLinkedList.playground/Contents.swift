import Foundation

//Given a non-empty, singly linked list with head node head, return a middle node of linked list.
//
//If there are two middle nodes, return the second middle node.
//
//
///Example 1:
///
///Input: [1,2,3,4,5]
///Output: Node 3 from this list (Serialization: [3,4,5])
///The returned node has value 3.  (The judge's serialization of this node is [3,4,5]).
///Note that we returned a ListNode object ans, such that:
///ans.val = 3, ans.next.val = 4, ans.next.next.val = 5, and ans.next.next.next = NULL.
///Example 2:
///
///Input: [1,2,3,4,5,6]
///Output: Node 4 from this list (Serialization: [4,5,6])
///Since the list has two middle nodes with values 3 and 4, we return the second one.
///
///
///Note:
///
///The number of nodes in the given list will be between 1 and 100.

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class MiddleOfTheLinkedList {

    // 4 ms
    func middleNode(_ head: ListNode?) -> ListNode? {
        guard head?.next != nil else { return head }

        var currentNode = head?.next
        var amountNodes = 1
        while (currentNode != nil) {
            currentNode = currentNode?.next
            amountNodes += 1
        }

        var index = 1
        let middle = Int(amountNodes / 2)
        currentNode = head?.next
        while (index != middle) {
            currentNode = currentNode?.next
            index += 1
        }

        return currentNode
    }

    // up to 0 ms
    func middleNode2(_ head: ListNode?) -> ListNode? {
        guard head?.next != nil else { return head }

        var currentNodeSlow = head?.next
        var currentNodeFast = head?.next
        while (currentNodeFast != nil) {
            currentNodeSlow = currentNodeSlow?.next
            currentNodeFast = currentNodeFast?.next?.next
        }
        return currentNodeSlow
    }
}

