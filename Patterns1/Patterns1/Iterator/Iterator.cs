using System;
using System.Collections.Generic;
using System.Linq;

namespace Patterns1.Iterator
{
    public interface IIterator
    {
        void First();
        string Next();
        string CurrentElement();
        bool IsDone();
    }

    public interface IIterator<T>
    {
        void First();
        T Next();
        T CurrentElement();
        bool IsDone();
    }

    public class IteratorArray : IIterator
    {
        private string[] _data;
        private int _position = 0;

        public IteratorArray(string[] data)
        {
            _data = data;
        }

        public string CurrentElement()
        {
            return _data[_position];
        }

        public void First()
        {
            _position = 0;
        }

        public bool IsDone()
        {
            return _position >= _data.Length;
        }

        public string Next()
        {
            return _data[_position++];
        }
    }

    public class IteratorList : IIterator
    {
        private List<string> _data;
        private int _position = 0;

        public IteratorList(List<string> data)
        {
            _data = data;
        }

        public string CurrentElement()
        {
            return _data.ElementAt(_position);
        }

        public void First()
        {
            _position = 0;
        }

        public bool IsDone()
        {
            return _position >= _data.Count();
        }

        public string Next()
        {
            return _data.ElementAt(_position++);
        }
    }

    public class IteratorListGeneric : IIterator<int>
    {
        public IteratorListGeneric()
        {
        }

        public int CurrentElement()
        {
            throw new NotImplementedException();
        }

        public void First()
        {
            throw new NotImplementedException();
        }

        public bool IsDone()
        {
            throw new NotImplementedException();
        }

        public int Next()
        {
            throw new NotImplementedException();
        }
    }


    public static class IteratorMethodLauncher
    {
        public static void Launch()
        {
            var aggArray = new AggregatorArray();
            var aggList = new AggregatorList();

            Console.WriteLine("------- Iterator array");
            Print(aggArray.GetIterator());
            Console.WriteLine("------- Iterator list");
            Print(aggList.GetIterator());
        }

        private static void Print(IIterator iterator)
        {
            iterator.First();

            while(!iterator.IsDone())
            {
                Console.WriteLine(iterator.Next());
            }
        }
    }
}
