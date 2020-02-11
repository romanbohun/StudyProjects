using System;
using System.Reflection;
using MethodDecorator.Fody.Interfaces;
//namespace CCC
//{
[module: PartialOnEntryLogger]

[AttributeUsage(AttributeTargets.Method | AttributeTargets.Constructor | AttributeTargets.Assembly | AttributeTargets.Module)]
public class PartialOnEntryLoggerAttribute : Attribute, IMethodDecorator
{
    public void Init(object instance, MethodBase method, object[] args)
    {

    }

    public void OnEntry()
    {
        System.Diagnostics.Debug.WriteLine($"OnEntry-+-");
    }

    public void OnException(Exception exception)
    {

    }

    public void OnExit()
    {

    }
}
//}
