using System;
using System.Collections.Generic;

namespace AlgorythmProblemSolutions.Medium
{
    public static class LongestSubstringWithoutRepeatingCharacters
    {
        public static int LengthOfLongestSubstring(string s)
        {
            var overallLength = 0;
            var currentLength = 0;
            var letterStorage = new Queue<Char>();
            for (int i = 0; i < s.Length; i++)
            {
                if (letterStorage.Contains(s[i]))
                {
                    while (letterStorage.Count != 0)
                    {
                        currentLength--;
                        if (letterStorage.Dequeue() == s[i])
                        {
                            break;
                        }
                    }
                }
                letterStorage.Enqueue(s[i]);
                currentLength++;
                overallLength = currentLength > overallLength ? currentLength : overallLength;
            }

            return overallLength;
        }
    }
}
