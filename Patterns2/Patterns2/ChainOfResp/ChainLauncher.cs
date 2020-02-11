using System;
namespace Patterns2.ChainOfResp
{
    public static class ChainLauncher
    {
        public static void Launch()
        {
            Console.WriteLine("\n===-- Chain of Responsibility --===");

            Approver bobby = new Director();
            Approver nicky = new VisePresident();
            Approver ronny = new President();

            bobby.SetSuccessor(nicky);
            nicky.SetSuccessor(ronny);

            Purchase purchase = new Purchase(1234, 350.0, "Assets");
            bobby.ProcessRequest(purchase);

            purchase = new Purchase(6543, 33390.10, "Project Poison");
            bobby.ProcessRequest(purchase);

            purchase = new Purchase(9821, 144000.0, "Project BBD");
            bobby.ProcessRequest(purchase);
        }
    }
}
