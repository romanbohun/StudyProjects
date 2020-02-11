using System;
using Patterns1.AbstractFactory;
using Patterns1.Decorator;
using Patterns1.FactoryMethod;
using Patterns1.Observer;
using Patterns1.Singleton;

namespace Patterns1
{
    class Program
    {
        static void Main(string[] args)
        {
            FactoryMethodLauncher.Launch();

            AbstractFactoryMethodLauncher.Launch();

            SingletonMethodLauncher.Launch();

            DecoratorMethodLauncher.Launch();

            Iterator.IteratorMethodLauncher.Launch();

            ObserverMethodLauncher.Launch();
            Console.ReadKey();
        }
    }
}
