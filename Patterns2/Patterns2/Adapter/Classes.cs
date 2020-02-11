using System;
namespace Patterns2.Adapter
{
    public class Driver
    {
        public void Travel(ITransport transport)
        {
            transport.Drive();
        }
    }

    public class Auto : ITransport
    {
        public void Drive()
        {
            Console.WriteLine("Car is driving on the road.");
        }
    }

    public interface IAnimal
    {
        void Move();
    }
    // Adaptee
    public class Camel : IAnimal
    {
        public void Move()
        {
            Console.WriteLine("Camel is walking on sands of desert");
        }
    }
}
