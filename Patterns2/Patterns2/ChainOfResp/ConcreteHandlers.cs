using System;
namespace Patterns2.ChainOfResp
{
    public class Director : Approver
    {
        public override void ProcessRequest(Purchase purchase)
        {
            if (purchase.Value < 10000.00)
            {
                Console.WriteLine("{0} approved request {1}", 
                                  this.GetType().Name, purchase.Id);
            }
            else  
            {
                Successor?.ProcessRequest(purchase);
            }
        }
    }

    public class VisePresident : Approver
    {
        public override void ProcessRequest(Purchase purchase)
        {
            if (purchase.Value < 25000.00)
            {
                Console.WriteLine("{0} approved request {1}",
                                  this.GetType().Name, purchase.Id);
            }
            else
            {
                Successor?.ProcessRequest(purchase);
            }
        }
    }

    public class President : Approver
    {
        public override void ProcessRequest(Purchase purchase)
        {
            if (purchase.Value < 100000.00)
            {
                Console.WriteLine("{0} approved request {1}",
                                  this.GetType().Name, purchase.Id);
            }
            else
            {
                Console.WriteLine("Request# {0} requires an executive meeting!", purchase.Id);
            }
        }
    }

}
