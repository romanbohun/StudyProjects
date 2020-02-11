using System;
using System.Collections.Generic;

namespace NumberRandomizator
{
    public sealed class CustomRandomizator
    {
        public int A { get; private set; }
        public int B { get; private set; }
        public int M { get; private set; }

        public CustomRandomizator()
        {

        }

        public CustomRandomizator(int a, int b, int m) : this()
        {
            Init(a, b, m);
        }

        public void Init(int a, int b, int m)
        {
            A = a;
            B = b;
            M = m;
        }

        public int Generate(int startNumber)
        {
            return GenerateNext(startNumber);
        }

        public IEnumerable<int> Generate(int startNumber, int collectionCapacity)
        {
            var result = new int[collectionCapacity];
            var prevResult = startNumber;

            for (int i = 0; i < collectionCapacity; i++)
            {
                prevResult = GenerateNext(prevResult);
                result[i] = prevResult;
            }
            
            return result;
        }
        
        private int GenerateNext(int number)
        {
            var result = (A * number + 5) % M;
            
            return result;
        }
    }
}