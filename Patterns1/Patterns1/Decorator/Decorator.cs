using System;
namespace Patterns1.Decorator
{
    //Component
    public abstract class Car
    {
        public string Description
        {
            get;
            set;
        }

        public abstract string GetDescription();
        public abstract double GetPrice();
    }

    //Decorator
    public class CarDecorator : Car
    {
        protected readonly Car _car;
        public CarDecorator(Car car)
        {
            _car = car;
        }

        public override string GetDescription()
        {
            return _car.GetDescription();
        }

        public override double GetPrice()
        {
            return _car.GetPrice();
        }
    }

    //Concrete Component
    public class CompactCar : Car
    {
        public CompactCar()
        {
            Description = "Compact Car";
        }

        public override string GetDescription()
        {
            return Description;
        }

        public override double GetPrice()
        {
            return 10000;
        }
    }

    //Concrete Decorators
    public class Navigation : CarDecorator
    {
        public Navigation(Car car) : base(car)
        {
            Description = "Navigation";
        }

        public override string GetDescription()
        {
            return $"{_car.GetDescription()}, {Description}";
        }

        public override double GetPrice()
        {
            return _car.GetPrice() + 1500;
        }
    }

    public class LeatherSeats : CarDecorator
    {
        public LeatherSeats(Car car) : base(car)
        {
            Description = "Leather seats";
        }

        public override string GetDescription()
        {
            return $"{_car.GetDescription()}, {Description}";
        }

        public override double GetPrice()
        {
            return _car.GetPrice() + 2500;
        }
    }

    public class SunRoof : CarDecorator
    {
        public SunRoof(Car car) : base(car)
        {
            Description = "Sun roof";
        }

        public override string GetDescription()
        {
            return $"{_car.GetDescription()}, {Description}";
        }

        public override double GetPrice()
        {
            return _car.GetPrice() + 6000;
        }
    }


    public static class DecoratorMethodLauncher
    {
        public static void Launch()
        {
            Car theCar = new CompactCar();
            theCar = new Navigation(theCar);
            theCar = new LeatherSeats(theCar);
            theCar = new SunRoof(theCar);

            Console.WriteLine("---------- DECORATOR ----------");
            Console.WriteLine(theCar.GetDescription());
            Console.WriteLine($"{theCar.GetPrice():C2}");
        }
    }
}
