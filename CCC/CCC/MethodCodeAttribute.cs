using System;
using System.Reflection;
using System.Threading.Tasks;
using CCC;
using MethodDecorator.Fody.Interfaces;

//[module: MethodCode]

[AttributeUsage(AttributeTargets.Method | AttributeTargets.Constructor)]
public class MethodCodeAttribute : Attribute, IMethodIdentifier, IMethodDecorator, IDisposable
{
    public string Id { get; private set; }

    public MethodCodeAttribute(string identifier)
    {
        Id = identifier;
    }

    private object _instance;
    //private MethodBase _method;

    public void Init(object instance, MethodBase method, object[] args)
    {
        System.Diagnostics.Debug.WriteLine("Init");
        //_instance = new WeakReference<object>(instance);
        _instance = instance;
        //_method = method;
    }

    public void OnEntry()
    {
        System.Diagnostics.Debug.WriteLine($"OnEntry {_instance?.GetType()}");
    }

    public void OnException(Exception exception)
    {
        System.Diagnostics.Debug.WriteLine($"OnException {_instance?.GetType()} - {exception.Message}");

        string sourceId = GetClassIdentifier();

        if (!string.IsNullOrEmpty(sourceId))
        {
            ThrowAggregatedException(sourceId, Id, exception);
        }

        Dispose();
        throw exception;
    }

    public void OnExit()
    {
        System.Diagnostics.Debug.WriteLine($"OnExit {_instance?.GetType()}");
        Dispose();
    }

    public void OnTaskContinuation(Task task)
    {
        System.Diagnostics.Debug.WriteLine($"OnTaskContinuation started {_instance?.GetType()}");

        task.ContinueWith(OnTaskFaulted, TaskContinuationOptions.OnlyOnFaulted);
        task.ContinueWith(OnTaskCancelled, TaskContinuationOptions.OnlyOnCanceled);
        task.ContinueWith(OnTaskCompleted, TaskContinuationOptions.OnlyOnRanToCompletion);

        System.Diagnostics.Debug.WriteLine($"OnTaskContinuation finished {_instance?.GetType()}");


    }

    private void OnTaskFaulted(Task t)
    {
        System.Diagnostics.Debug.WriteLine($"OnTaskFaulted ------ {_instance?.GetType()}");

        string sourceId = GetClassIdentifier();

        if (!string.IsNullOrEmpty(sourceId))
        {
            ThrowAggregatedException(sourceId, Id, t.Exception);
        }

        Dispose();
    }

    private void OnTaskCancelled(Task t)
    {
        System.Diagnostics.Debug.WriteLine($"OnTaskCancelled ------ {_instance?.GetType()}");
    }

    private void OnTaskCompleted(Task t)
    {
        System.Diagnostics.Debug.WriteLine($"OnTaskCompleted ------ {_instance?.GetType()}");
    }

    public void Dispose()
    {
        _instance = null;
        System.Diagnostics.Debug.WriteLine($"Dispose {_instance?.GetType()}");
    }

    private string GetClassIdentifier()
    {
        if (_instance is IClassIdentifier source)
        {
            return source.Id;
        }
        else if (_instance != null)
        {
            return _instance.GetType().ToString();
        }

        return "";
    }

    //private string GetMethodIdentifier()
    //{
    //    if (_method == null)
    //    {
    //        return "";
    //    }
    //    else
    //    { 
    //        var attrib = _method.GetCustomAttribute(typeof(MethodCodeAttribute))
    //    }
    //}

    private void ThrowAggregatedException(string sourceId, string methodId, Exception ex)
    {
        throw new AggregatedException(sourceId, methodId, "", ex);
    }
}

public interface IMethodIdentifier
{ 
    string Id { get; }
}

public interface IClassIdentifier
{
    string Id { get; }
}