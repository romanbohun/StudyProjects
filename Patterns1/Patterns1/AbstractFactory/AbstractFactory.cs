using System;
namespace Patterns1.AbstractFactory
{
    public interface IProductA
    {

    }

    public interface IProductB
    {

    }

    public interface IProductFactory
    {
        IProductA CreateProductA();
        IProductB CreateProdcutB();
    }

    public class ProductA1 : IProductA
    {
        public ProductA1()
        {
            Console.WriteLine("ProductA1 created");
        }
    }

    public class ProductB1 : IProductB
    {
        public ProductB1()
        {
            Console.WriteLine("ProductB1 created");
        }
    }

    public class ProductA2 : IProductA
    {
        public ProductA2()
        {
            Console.WriteLine("ProductA2 created");
        }
    }

    public class ProductB2 : IProductB
    {
        public ProductB2()
        {
            Console.WriteLine("ProductB2 created");
        }
    }

    public class ProductFactory1 : IProductFactory
    {
        public ProductFactory1()
        {
        }

        public IProductA CreateProductA()
        {
            return new ProductA1();
        }

        public IProductB CreateProdcutB()
        {
            return new ProductB1();
        }
    }

    public class ProductFactory2 : IProductFactory
    {
        public IProductB CreateProdcutB()
        {
            return new ProductB2();
        }

        public IProductA CreateProductA()
        {
            return new ProductA2();
        }
    }

    public static class AbstractFactoryMethodLauncher
    {
        public static void Launch()
        {
            var pFactory1 = new ProductFactory1();
            var pFactory2 = new ProductFactory2();

            Console.WriteLine("Info for Factory 1:");
            PrintProductInfo(pFactory1);

            Console.WriteLine("Info for Factory 2:");
            PrintProductInfo(pFactory2);
        }

        private static void PrintProductInfo(IProductFactory productFactory)
        {
            //Print happens in constractors of each product
            //Of course, we can added, for example, PrintProductInfo() method in IProduct1, IProduct2 interfaces
            var pa1 = productFactory.CreateProductA();
            var pa2 = productFactory.CreateProdcutB();
        }
    }
}

