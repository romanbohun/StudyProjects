//Definition for singly-linked list.
public class ListNode: CustomStringConvertible {
      public var val: Int
      public var next: ListNode?
      public init() { self.val = 0; self.next = nil; }
      public init(_ val: Int) { self.val = val; self.next = nil; }
      public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }

    public var description: String {
        return String(val)
    }

  }


func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
    guard let second = head?.next else {
        return nil
    }

    var arr = [head, second]

    var currentNode = second.next
    while currentNode != nil {
        arr.append(currentNode)
        currentNode = currentNode?.next
    }

    if n == 1 {
        arr[arr.count - 2]?.next = nil
    } else if arr.count == n {
        return arr[arr.count - n + 1]
    } else {
        arr[arr.count - 1 - n]?.next = arr[arr.count - 1 - n + 2]
    }

    return head
}


func getNode() -> ListNode {
    return ListNode(1, ListNode(2, ListNode(3, ListNode(4, ListNode(5)))))
}

func getNode2() -> ListNode {
    return ListNode(1, ListNode(2))
}

func getNode3() -> ListNode {
    return ListNode(1, ListNode(2))
}


func printNode(_ head: ListNode?) {
    var currentNode = head
    while currentNode != nil {
        print(currentNode)
        currentNode = currentNode?.next
    }
}

removeNthFromEnd(getNode3(), 2)
