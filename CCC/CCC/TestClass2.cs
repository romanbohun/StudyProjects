using System;
using System.Threading.Tasks;

namespace CCC
{
    public class TestClass2
    {
        private int _i;

        [DefaultLogger]
        public TestClass2(int intAgr)
        {
            _i = intAgr;
        }

        [DefaultLogger]
        public async Task RunMehtod2()
        {
            System.Diagnostics.Debug.WriteLine("Method2 body is running before await");

            await Task.Delay(5000);

            System.Diagnostics.Debug.WriteLine("Method2 body is running after await");
        }
    }
}
