using System;
using Patterns2.Adapter;
using Patterns2.Builder;
using Patterns2.ChainOfResp;

namespace Patterns2
{
    class Program
    {
        static void Main(string[] args)
        {
            BuilderLauncher.Launch();
            AdapterLauncher.Launch();
            ChainLauncher.Launch();
        }
    }
}
