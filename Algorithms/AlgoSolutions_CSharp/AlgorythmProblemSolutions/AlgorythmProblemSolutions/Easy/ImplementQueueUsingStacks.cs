using System;
using System.Collections.Generic;

namespace AlgorythmProblemSolutions.Easy
{
    public class MyQueue1
    {
        private Stack<int> _stack = new Stack<int>();
        private Stack<int> _stack2 = new Stack<int>();
        
        /** Initialize your data structure here. */
        public MyQueue1()
        {

        }

        /** Push element x to the back of queue. */
        public void Push(int x)
        {
            while (_stack.Count > 0)
            {
                _stack2.Push(_stack.Pop());
            }
            _stack.Push(x);

            while (_stack2.Count > 0)
            {
                _stack.Push(_stack2.Pop());
            }

            //_stack2.Clear();
            //foreach (var item in _stack)
            //{
            //    _stack2.Push(item);
            //}

            //_stack.Clear();
            //_stack.Push(x);

            //foreach (var item in _stack2)
            //{
            //    _stack.Push(item);
            //}
        }

        /** Removes the element from in front of queue and returns that element. */
        public int Pop()
        {
            return _stack.Pop();
        }

        /** Get the front element. */
        public int Peek()
        {
            return _stack.Peek();
        }

        /** Returns whether the queue is empty. */
        public bool Empty()
        {
            return _stack.Count == 0;
        }
    }
}
