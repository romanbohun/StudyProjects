using System;

namespace CCC
{
    public class ExceptionTestClass2BL : IClassIdentifier
    {
        public ExceptionTestClass2BL()
        {
        }

        public string Id => "BL";

        [MethodCode("L1")]
        public void DoSomeBlLogic()
        {
            var dal = new ExceptionTestClass3Dal();
            dal.DoSomeDalLogic();
        }
    }
}
