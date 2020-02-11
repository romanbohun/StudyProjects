using System;
namespace Patterns1.Singleton
{
    public class Singleton
    {
        private static readonly object _lock = new object();

        public int Salary
        {
            get;
            private set;
        }

        public string EmployeeName
        {
            get;
            private set;
        }

        private static Singleton _instance;
        public static Singleton Instance
        {
            get
            {
                // Lock here is to be a Thread safety
                lock(_lock)
                {
                    if (ReferenceEquals(_instance, null))
                    {
                        _instance = new Singleton();

                        Console.WriteLine("Singleton instance has been created very first time");
                    }

                    Console.WriteLine("Return _instance");

                    return _instance;
                }
            }
        }

        public Singleton()
        {
            Salary = 65000;
            EmployeeName = "John Dou";
        }
    }

    public static class SingletonMethodLauncher
    {
        public static void Launch()
        {
            Console.WriteLine("Singleton pattern launch:");

            Console.WriteLine($"{Singleton.Instance.EmployeeName} : {Singleton.Instance.Salary}$");
        }
    }
}
