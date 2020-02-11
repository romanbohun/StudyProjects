using Calculator;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace tdd1
{
    [TestClass]
    public class CalculatorTest
    {
        [TestMethod]
        public void AnnualSalaryTest()
        {
            //Arrange
            SalaryCalculator sc = new SalaryCalculator();

            //Set
            decimal annualSalary = sc.GetAnnualSalary(50);

            //Assert
            Assert.AreEqual(104000, annualSalary);
        }

        [TestMethod]
        public void HourlyWageTest()
        {
            //Arrange
            SalaryCalculator sc = new SalaryCalculator();

            //Set
            decimal hourlyWage = sc.GetHourlyWage(52000);

            //Assert
            Assert.AreEqual(25, hourlyWage);
        }
    }
}
