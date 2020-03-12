using System;
namespace AlgorythmProblemSolutions.Medium
{
    public class ListNode
    {
        public int val;
        public ListNode next;
        public ListNode(int x) { val = x; }
    }

    public static class LinkedList_TwoSum
    {
        public static ListNode AddTwoNumbers(ListNode l1, ListNode l2)
        {
            if (l1 == null) return l2;
            if (l2 == null) return l1;

            ListNode head = null;
            ListNode tail = null;

            var reminder = 0;
            var leftNode = l1;
            var rightNode = l2;

            while (true)
            {
                var sum = (leftNode == null ? 0 : leftNode.val) + (rightNode == null ? 0 : rightNode.val) + reminder;
                if (sum >= 10)
                {
                    reminder = 1;
                    sum = sum - 10;
                }
                else
                {
                    reminder = 0;
                }

                var tempNode = new ListNode(sum);
                if (head == null)
                {
                    head = tempNode;
                    tail = tempNode;
                }
                else
                {
                    tail.next = tempNode;
                    tail = tempNode;
                }

                leftNode = leftNode?.next;
                rightNode = rightNode?.next;

                if (leftNode == null && rightNode == null)
                {
                    break;
                }
            }

            if (reminder > 0)
            {
                var tempReminderNode = new ListNode(reminder);
                tail.next = tempReminderNode;
            }

            return head;
        }
    }
}
