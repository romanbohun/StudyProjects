using System;
using System.Collections.Generic;

namespace Patterns2.Builder
{
    public static class BuilderLauncher
    {
        public static void Launch()
        {
            Console.WriteLine("===-- Builder --===");

            var superBuilder = new SuperCarBuilder();
            var notSuperBuilder = new NotSoSuperCarBuilder();

            var factory = new CarFactory();
            var builders = new List<CarBuilder>() { superBuilder, notSuperBuilder };

            foreach (var item in builders)
            {
                var c = factory.Build(item);
                Console.WriteLine($"The car requested by "+
                                  $"{c.GetType().Name}: "+
                                  $"\n ---------------------------"+
                                  $"\nHourse Power: {c.HoursePower} "+
                                  $"\nImpressive Feature: {c.MostImpressiveFeature} " +
                                  $"\nTop Speed: {c.TopSpeedMPH} mph \n");
            }
        }
    }
}
