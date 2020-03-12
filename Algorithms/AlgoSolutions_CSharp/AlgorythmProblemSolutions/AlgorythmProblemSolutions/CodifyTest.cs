using System;
using System.Collections.Generic;
using System.Linq;

namespace AlgorythmProblemSolutions
{
    public static class CodifyTest1
    {
        public static int solution(int A, int B, int C, int D)
        {
            var arrayOfInputDigits = new int[] { A, B, C, D };
            var cache = new HashSet<String>();
            for (int i = 0; i < arrayOfInputDigits.Length; i++)
            {
                for (int j = 0; j < arrayOfInputDigits.Length; j++)
                {
                    if (i == j) continue;

                    for (int k = 0; k < arrayOfInputDigits.Length; k++)
                    {
                        if (j == k || i == k) continue;

                        for (int l = 0; l < arrayOfInputDigits.Length; l++)
                        {
                            if (l == k || l == i || l == j) continue;

                            var cacheKey = $"{arrayOfInputDigits[i]}{arrayOfInputDigits[j]}:{arrayOfInputDigits[k]}{arrayOfInputDigits[l]}";
                            if ((IsHour(arrayOfInputDigits[i], arrayOfInputDigits[j]) && IsMinutes(arrayOfInputDigits[k], arrayOfInputDigits[l])) && !cache.Contains(cacheKey))
                            {
                                cache.Add(cacheKey);
                                Console.WriteLine("TIME -> {0}{1}:{2}{3}", arrayOfInputDigits[i], arrayOfInputDigits[j], arrayOfInputDigits[k], arrayOfInputDigits[l]);
                            }
                        }
                    }
                }
            }
            return cache.Count;
        }

        private static bool IsHour(int digit1, int digit2)
        {
            int multyplyOn101 = (digit1 * 10) + digit2;
            //Console.WriteLine("HOURS-> {0}", multyplyOn101);
            return multyplyOn101 < 24;
        }

        private static bool IsMinutes(int digit1, int digit2)
        {
            int multyplyOn101 = (digit1 * 10) + digit2;
            //Console.WriteLine("MINUTES-> {0}", multyplyOn101);
            return multyplyOn101 < 60;
        }

        private static int gethour(int digit1, int digit2)
        {
            int multyplyOn10 = (digit1 * 10) + digit2;
            if (multyplyOn10 < 24)
            {
                return multyplyOn10;
            }
            return -1;
        }

        private static int getminute(int digit1, int digit2)
        {
            int multyplyOn10 = (digit1 * 10) + digit2;
            if (multyplyOn10 < 60)
            {
                return multyplyOn10;
            }
            return -1;
        }

        private static int[] hours(this int[] array, int digit)
        {
            var result = new HashSet<int>();
            for (int i = 0; i < array.Length; i++)
            {
                //if (array[i] == digit)
                //{
                //    continue;
                //}

                int multyplyOn10 = 0;
                if (array[i] == 0)
                {
                    multyplyOn10 = digit;
                }
                else
                {
                    multyplyOn10 = (array[i] * 10) + digit;
                }

                if (multyplyOn10 < 24 && !result.Contains(multyplyOn10))
                {
                    result.Add(multyplyOn10);
                }
            }

            return result.ToArray();
        }

        private static int[] minutes(this int[] array, int digit)
        {
            var result = new HashSet<int>();
            for (int i = 0; i < array.Length; i++)
            {
                //if (array[i] == digit)
                //{
                //    continue;
                //}

                int multyplyOn10 = 0;
                if (array[i] == 0)
                {
                    multyplyOn10 = digit;
                }
                else
                {
                    multyplyOn10 = (array[i] * 10) + digit;
                }

                if (multyplyOn10 < 60 && !result.Contains(multyplyOn10))
                {
                    result.Add(multyplyOn10);
                }
            }

            return result.ToArray();
        }
    }
}
