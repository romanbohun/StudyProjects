using System;

namespace Stacks_CSharp
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            var stack = new StackLinkedList<int>();
            stack.Push(0);
            stack.Push(1);
            stack.Push(2);
            stack.Push(3);
            Console.WriteLine(stack.Peek());
            Console.WriteLine(stack.Peek());

            Console.WriteLine(stack.Pop());
            Console.WriteLine(stack.Pop());
            Console.WriteLine(stack.Pop());
            Console.WriteLine(stack.Pop());
            Console.WriteLine(stack.Pop());
        }
    }

    public class Node<T>
    {
        public T value { get; set; }
        public Node<T> next { get; set; }

        public Node(T value)
        {
            this.value = value;
        }
    }

    public class StackLinkedList<T>
    {
        private Node<T> _tail;

        public int Length { get; private set; } = 0;

        public void Push(T value)
        {
            var node = new Node<T>(value);
            Length++;
            if (_tail == null)
            {
                _tail = node;
                return;
            }

            node.next = _tail;
            _tail = node;
        }

        public T Pop()
        {
            if (_tail == null)
            {
                throw new InvalidOperationException("Stack is empty.");
            }
            var result = _tail;
            _tail = _tail?.next;
            Length--;
            return result.value;
        }

        public T Peek()
        {
            if (_tail == null)
            {
                throw new InvalidOperationException("Stack is empty.");
            }
            return _tail.value;
        }
    }
}