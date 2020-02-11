using System;
using System.Reflection;
using System.Threading.Tasks;
using MethodDecorator.Fody.Interfaces;

[module: DefaultLogger]

//namespace CCC
//{
[AttributeUsage(AttributeTargets.Method | AttributeTargets.Constructor | AttributeTargets.Assembly | AttributeTargets.Module)]
public class DefaultLoggerAttribute : Attribute, IMethodDecorator, IDisposable
{
    private object _logObject;

    public void Init(object instance, MethodBase method, object[] args)
    {
        System.Diagnostics.Debug.WriteLine("Init");
        _logObject = instance;
    }

    public void OnEntry()
    {
        System.Diagnostics.Debug.WriteLine($"OnEntry {_logObject?.GetType()}");
    }

    public void OnException(Exception exception)
    {
        System.Diagnostics.Debug.WriteLine($"OnException {_logObject?.GetType()} - {exception.Message}");
        Dispose();
    }

    public void OnExit()
    {
        System.Diagnostics.Debug.WriteLine($"OnExit {_logObject?.GetType()}");
        Dispose();
    }

    public void OnTaskContinuation(Task task)
    {
        System.Diagnostics.Debug.WriteLine($"OnTaskContinuation started {_logObject?.GetType()}");

        task.ContinueWith(OnTaskFaulted, TaskContinuationOptions.OnlyOnFaulted);
        task.ContinueWith(OnTaskCancelled, TaskContinuationOptions.OnlyOnCanceled);
        task.ContinueWith(OnTaskCompleted, TaskContinuationOptions.OnlyOnRanToCompletion);

        System.Diagnostics.Debug.WriteLine($"OnTaskContinuation finished {_logObject?.GetType()}");


    }

    private void OnTaskFaulted(Task t)
    {
        System.Diagnostics.Debug.WriteLine($"OnTaskFaulted ------ {_logObject?.GetType()}");
    }

    private void OnTaskCancelled(Task t)
    {
        System.Diagnostics.Debug.WriteLine($"OnTaskCancelled ------ {_logObject?.GetType()}");
    }

    private void OnTaskCompleted(Task t)
    {
        System.Diagnostics.Debug.WriteLine($"OnTaskCompleted ------ {_logObject?.GetType()}");
    }

    public void Dispose()
    {
        _logObject = null;
        System.Diagnostics.Debug.WriteLine($"Dispose {_logObject?.GetType()}");
    }
}
//}
