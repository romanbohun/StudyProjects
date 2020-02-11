using System;
namespace Patterns2.Adapter
{
    public static class AdapterLauncher
    {
        public static void Launch()
        {
            Console.WriteLine("===-- Adapter --===");

            var driver = new Driver();
            var auto = new Auto();

            driver.Travel(auto);

            var camel = new Camel();
            var animalAdapter = new AnimalToTransportAdapter(camel);

            driver.Travel(animalAdapter);
        }
    }
}
