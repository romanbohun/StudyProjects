using System;

namespace Queue_CSharp
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            var queue = new QueueLinkedList<int>();
            queue.Enqueue(0);
            queue.Enqueue(1);
            queue.Enqueue(2);
            queue.Enqueue(3);

            Console.WriteLine(queue.Dequeue());
            Console.WriteLine(queue.Dequeue());
            Console.WriteLine(queue.Dequeue());
            Console.WriteLine(queue.Peek());
            Console.WriteLine(queue.Dequeue());
            Console.WriteLine(queue.Dequeue());

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

    public class QueueLinkedList<T>
    {
        private Node<T> _first;
        private Node<T> _last;

        public int Length { get; private set; }

        public void Enqueue(T value)
        {
            var node = new Node<T>(value);
            Length++;

            if (_first == null)
            {
                _first = _last = node;
                return;
            }

            _last.next = node;
            _last = node;
        }

        public T Peek()
        {
            if (_first == null)
            {
                throw new InvalidOperationException("Queue is empty.");
            }

            return _first.value;
        }

        public T Dequeue()
        {
            if (_first == null)
            {
                _last = null;
                throw new InvalidOperationException("Queue is empty.");
            }

            var temp = _first;
            _first = _first.next;
            Length--;
            return temp.value;
        }
    }

}
