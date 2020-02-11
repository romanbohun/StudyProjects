using System;
namespace Patterns2.Builder
{
    public abstract class CarBuilder
    {
        protected readonly Car _car = new Car();
        public abstract void SetHoursePower();
        public abstract void SetTopSpeed();
        public abstract void SetImpressiveFeature();

        public virtual Car GetCar()
        {
            return _car;
        }
    }
}
