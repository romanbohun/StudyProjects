public class ListNode: CustomStringConvertible {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
    
    public var description: String {
        var node: ListNode? = self
        var str = ""
        while node != nil {
            str += String(node!.val) + " "
            node = node?.next
        }
        return str
    }
}

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    guard l1 != nil else { return l2 }
    guard l2 != nil else { return l1 }
    
    var head: ListNode? = nil
    var tail: ListNode? = nil
    
    var reminder = 0
    var leftNode = l1
    var rightNode = l2
    
    while true {
        var sum = reminder
        if let leftNodeVal = leftNode?.val {
            sum += leftNodeVal
        }
        if let rightNodeVal = rightNode?.val {
            sum += rightNodeVal
        }
        
        if sum >= 10 {
            reminder = 1
            sum = sum - 10
        } else {
            reminder = 0
        }
        
        let sumNode = ListNode(sum)
        if head == nil {
            head = sumNode
            tail = sumNode
        } else {
            tail?.next = sumNode
            tail = sumNode
        }
        
        leftNode = leftNode?.next
        rightNode = rightNode?.next
        
        if leftNode == nil && rightNode == nil {
            break
        }
    }
    
    if reminder > 0 {
        let tempReminderNode = ListNode(reminder)
        tail?.next = tempReminderNode
    }
    
    return head
}

addTwoNumbers(ListNode(5), ListNode(5))
addTwoNumbers(ListNode(9), ListNode(9))
