using System;
using System.Collections.Generic;
using Moq;

namespace Polymorphism
{
    public class Employee
    {
        public virtual string CalculateWeeklySalary(int weeklyHours, int wage)
        {
            var salary = 40 * wage;

            var result = string.Format("\nThis ANGRY EMPLOYEE worked {0} hrs. " +
                              "Paid for 40 hrs at $ {1}" +
                              "/hr = ${2} \n", weeklyHours, wage, salary);
            Console.WriteLine("\n" + result + "\n");
            Console.WriteLine("---------------------------------------------\n");

            return result;
        }
    }

    public class Contractor : Employee
    {
        public override string CalculateWeeklySalary(int weeklyHours, int wage)
        {
            var salary = weeklyHours * wage;
            var result = string.Format("\nThis HAPPY CONTRACTOR worked {0} hrs. " +
                              "Paid for {0} hrs at $ {1}" +
                              "/hr = ${2} ", weeklyHours, wage, salary);

            Console.WriteLine("\n" + result + "\n");
            Console.WriteLine("---------------------------------------------\n");

            return result;
        }
    }


    public class Program
    {

        private static void Main(string[] args)
        {
            const int hours = 55, wage = 70;
            //List<Employee> employees = Utils.GetEmployees();

            var mock = new Mock<UtilsMock>();
            mock.Setup(j => j.GetEmployees()).Returns(() =>
                                                      new List<Employee> { new Contractor(), new Employee() });

            List<Employee> employees = mock.Object.GetEmployees();

            foreach (var e in employees)
            {
                e.CalculateWeeklySalary(hours, wage);
            }
        }
    }

    public static class Utils
    {
        public static List<Employee> GetEmployees()
        {
            var someEmployee = new Employee();
            var someContractor = new Contractor();
            var everyone = new List<Employee> { someEmployee, someContractor };
            return everyone;
        }
    }

    public class UtilsMock
    {
        public virtual List<Employee> GetEmployees()
        {
            throw new NotImplementedException();
        }
    }
}
