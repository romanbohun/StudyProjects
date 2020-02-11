using System;
using System.Collections.Generic;

namespace Patterns1.Observer
{
    public interface ICelebrity
    {
        string FullName { get; }
        string Tweet { get; }

        void SendTweet(string message);
        void AddFollower(IFollower follower);
        void RemoveFollower(IFollower follower);
    }

    public class Celebrity<T> : ICelebrity
        where T : ICelebrityInfo
    {
        private List<IFollower> _funs = new List<IFollower>();
        private T _celebrityInfo;

        public Celebrity(T celebrityInfo)
        {
            _celebrityInfo = celebrityInfo;
        }

        public string FullName => _celebrityInfo.FullName;

        public string Tweet 
        {
            get;
            private set;
        }

        public void AddFollower(IFollower follower)
        {
            _funs.Add(follower);
        }

        public void RemoveFollower(IFollower follower)
        {
            _funs.Remove(follower);
        }

        public void SendTweet(string message)
        {
            Tweet = message;
            foreach (var fun in _funs)
            {
                fun.Notify(this);
            }
        }
    }

    public interface ICelebrityInfo
    {
        string FullName { get; }
    }

    public class CelebrityInfo : ICelebrityInfo
    {
        public string FullName { get; private set; }

        public CelebrityInfo(string name)
        {
            FullName = name;
        }
    }
}
