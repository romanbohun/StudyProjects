using System;
using System.Collections.Generic;

namespace AlgorythmProblemSolutions.Easy
{
    public class MyStack1
    {
        private Queue<int> _queue = new Queue<int>();
        private Queue<int> _queue2 = new Queue<int>();

        /** Initialize your data structure here. */
        public MyStack1()
        {

        }

        /** Push element x onto stack. */
        public void Push(int x)
        {
            _queue2.Enqueue(x);
            while (_queue.Count > 0)
            {
                _queue2.Enqueue(_queue.Dequeue());
            }

            var temp = _queue;
            _queue = _queue2;
            _queue2 = temp;
        }

        /** Removes the element on top of the stack and returns that element. */
        public int Pop()
        {
            return _queue.Dequeue();
        }

        /** Get the top element. */
        public int Top()
        {
            return _queue.Peek();
        }

        /** Returns whether the stack is empty. */
        public bool Empty()
        {
            return _queue.Count == 0;
        }
    }

}
