using System;
using Microsoft.AppCenter.Crashes;

namespace CCC
{
    public class ExceptionTestClass3Dal : IClassIdentifier
    {
        public ExceptionTestClass3Dal()
        {
        }

        public string Id => "DAL";

        [MethodCode("L1")]
        public void DoSomeDalLogic()
        {
            throw new Exception("Some troubles");
            //Crashes.GenerateTestCrash();
        }
    }
}
