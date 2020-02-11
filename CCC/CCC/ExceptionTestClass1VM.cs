using System;
namespace CCC
{
    public class ExceptionTestClass1VM : IClassIdentifier
    {
        public ExceptionTestClass1VM()
        {
        }

        public string Id => "VM";


        [MethodCode("L1")]
        public void DoSomeLogic1()
        {
            var bl = new ExceptionTestClass2BL();
            bl.DoSomeBlLogic();
        }
    }
}
