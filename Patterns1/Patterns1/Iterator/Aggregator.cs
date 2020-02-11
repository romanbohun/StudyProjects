using System;
using System.Collections.Generic;

namespace Patterns1.Iterator
{

    public interface IAggregator
    {
        IIterator GetIterator();
    }

    public class AggregatorArray : IAggregator
    {
        private string[] _data;

        public AggregatorArray()
        {
            _data = new string[5] { "Array Item 1", "Array Item 2", "Array Item 3", "Array Item 4", "Array Item 5" };
        }

        public IIterator GetIterator()
        {
            return new IteratorArray(_data);
        }
    }

    public class AggregatorList : IAggregator
    {
        private List<string> _data;

        public AggregatorList()
        {
            _data = new List<string> { "List Item 1", "List Item 2", "List Item 3", "List Item 4", "List Item 5" };
        }

        public IIterator GetIterator()
        {
            return new IteratorList(_data);
        }
    }
}
