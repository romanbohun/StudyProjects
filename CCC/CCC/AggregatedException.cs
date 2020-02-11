using System;

namespace CCC
{
    public class AggregatedException : Exception, IAggregatedException
    {
        public string SourceId { get; }

        public string MethodId { get; }


        public AggregatedException(
            string sourceId, 
            string methodId, 
            string message, 
            Exception innerException) : base(message, innerException)
        {
            SourceId = sourceId;
            MethodId = methodId;
        }

        public string FullRoute()
        {
            var res = Route(this);
            return res;
        }

        private string Route(Exception exception)
        {
            string result = string.Empty;

            if (exception is AggregatedException aggEx)
            {
                result = exception.ToString() + " - ";
                result += Route(exception.InnerException);
            }
            //else if (exception != null)
            //{
            //    result += exception.GetType().ToString();
            //}

            return result;
        }

        public override string ToString()
        {
            return $"{SourceId}{MethodId}";
        }

        public Exception GetFirstException()
        {
            return GetException(this);
        }

        private Exception GetException(Exception ex)
        { 
            if (ex.InnerException == null)
            {
                return ex;
            }

            return GetException(ex.InnerException);
        }

        //public void RemoveFirstExceptionFromStack(Exception ex)
        //{
        //    this.RemoveException(ex);
        //}

        //private void RemoveException(Exception ex)
        //{ 

        //}
    }

    public interface IAggregatedException
    { 
        string SourceId { get; }
        string MethodId { get; }
    }
}
