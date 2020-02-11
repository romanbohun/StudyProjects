using System;
namespace Patterns2.Builder
{
    public class NotSoSuperCarBuilder : CarBuilder
    {
        public override void SetHoursePower()
        {
            _car.HoursePower = 120;
        }

        public override void SetImpressiveFeature()
        {
            _car.MostImpressiveFeature = "Has air conditioning";
        }

        public override void SetTopSpeed()
        {
            _car.TopSpeedMPH = 70;
        }
    }

    public class SuperCarBuilder : CarBuilder
    {
        public override void SetHoursePower()
        {
            _car.HoursePower = 1640;
        }

        public override void SetImpressiveFeature()
        {
            _car.MostImpressiveFeature = "Can fly";
        }

        public override void SetTopSpeed()
        {
            _car.TopSpeedMPH = 600;
        }
    }
}
