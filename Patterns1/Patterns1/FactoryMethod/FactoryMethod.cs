namespace Patterns1.FactoryMethod
{
    public abstract class BaseProduct
    {
        public int Height { get; set; }
        public int Width { get; set; }

        public void Print()
        {
            System.Console.WriteLine(ToString());
        }

        public override string ToString()
        {
            return $"{Height} {Width}";
        }
    }

    public class ProductA : BaseProduct
    {
        public ProductA()
        {
            this.Height = 1000;
            this.Width = 2000;

            Print();
        }
    }

    public class ProductB : BaseProduct
    {
        public ProductB()
        {
            this.Height = 3000;
            this.Width = 4000;

            Print();
        }
    }

    public enum ProductType
    {
        ProductA = 100,
        ProductB = 200
    }

    public interface IProductFactory
    {
        BaseProduct GetProductByType(ProductType productType);
    }

    public class ProductFactory : IProductFactory
    {
        public ProductFactory()
        {
        }

        public BaseProduct GetProductByType(ProductType productType)
        {
            if (productType == ProductType.ProductA)
            {
                return new ProductA();
            }
            else if (productType == ProductType.ProductB)
            {
                return new ProductB();
            }

            return null;
        }
    }

    public static class FactoryMethodLauncher
    {
        public static void Launch()
        {
            var pFactory = new ProductFactory();

            var pA = pFactory.GetProductByType(ProductType.ProductA);
            var pB = pFactory.GetProductByType(ProductType.ProductB);
        }
    }
}
