using System;
namespace CCC
{
    public class TestClass
    {
        public TestClass()
        {
        }

        [PartialOnEntryLogger]
        public void RunMehtod()
        {
            System.Diagnostics.Debug.WriteLine("Method body is running");
        }
    }
}
