using System;
namespace Patterns1.Observer
{
    public interface IFollower
    {
        void Notify(ICelebrity celebrity);
    }

    public class Follower : IFollower
    {
        private string _fullName;

        public Follower(string name)
        {
            _fullName = name;
        }

        public void Notify(ICelebrity celebrity)
        {
            Console.WriteLine($"{_fullName} receives tweet from {celebrity.FullName}: {celebrity.Tweet}");
        }
    }


    public static class ObserverMethodLauncher
    {
        public static void Launch()
        {
            var celeb1 = new Celebrity<CelebrityInfo>(new CelebrityInfo("Armin van Buuren"));
            var celeb2 = new Celebrity<CelebrityInfo>(new CelebrityInfo("Above and Beyond"));
            var celeb3 = new Celebrity<CelebrityInfo>(new CelebrityInfo("Andre Tanneberger"));

            var flwr1 = new Follower("Ivan");
            var flwr2 = new Follower("Roman");
            var flwr3 = new Follower("Marina");
            var flwr4 = new Follower("Eugene");
            var flwr5 = new Follower("Daniil");
            var flwr6 = new Follower("Anastasiia");

            celeb1.AddFollower(flwr1);
            celeb1.AddFollower(flwr2);
            celeb1.AddFollower(flwr3);
            celeb1.AddFollower(flwr4);
            celeb1.AddFollower(flwr5);

            celeb2.AddFollower(flwr4);
            celeb2.AddFollower(flwr5);

            celeb3.AddFollower(flwr2);
            celeb3.AddFollower(flwr3);
            celeb3.AddFollower(flwr6);

            Console.WriteLine("------- Observer tweets");

            celeb1.SendTweet("Hey, whats up?");
            celeb2.SendTweet("Hong Kong tour was incredible!!! Thank you!");
            celeb3.SendTweet("Kyiv, see next saturday!");


        }
    }
}
