using System;
namespace Patterns2.Adapter
{
    public class AnimalToTransportAdapter : ITransport
    {
        private IAnimal _animal;
        public AnimalToTransportAdapter(IAnimal animal)
        {
            _animal = animal;
        }

        public void Drive()
        {
            _animal.Move();
        }
    }
}
