using System;
using System.Collections.Generic;

namespace AlgorythmProblemSolutions
{
    public static class CodifyTest2
    {
        public static int solution(int N)
        {
            var isNegative = N < 0;
            var result = 8000 * (isNegative ? -1 : 0);
            N = Math.Abs(N);
            var operateDigit = 5;
            var divisor = 1;
            while (Math.Abs(N) / divisor >= 10)
                divisor *= 10;

            divisor = divisor * 10;

            while (divisor >= 1)
            {
                var digit = N / divisor; // 2
                var digit2 = digit * divisor; // 200
                var reminder = N - digit2;
                var digit3 = digit2 * 10; // 2000
                var digit4 = operateDigit * divisor; // 500
                var digit5 = digit3 + digit4; // 2500
                var digit6 = (digit5 + reminder) * (isNegative ? -1 : 1);

                if (result < digit6)
                {
                    result = digit6;
                }
                divisor /= 10;
            }

            return result;
        }
    }
}
