using System;
namespace Patterns2.Builder
{
    public class CarFactory
    {
        public Car Build(CarBuilder builder)
        {
            builder.SetTopSpeed();
            builder.SetHoursePower();
            builder.SetImpressiveFeature();

            return builder.GetCar();
        }
    }
}
