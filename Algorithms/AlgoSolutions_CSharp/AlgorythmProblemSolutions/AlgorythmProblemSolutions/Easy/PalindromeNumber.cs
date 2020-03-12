using System;

namespace AlgorythmProblemSolutions.Easy
{
    public static class PalindromeNumber
    {
        public static bool IsPalindrome(int x)
        {
            var divisor = 1;
            while (x / divisor >= 10)
                divisor *= 10;

            while (x != 0)
            {
                var leadingDigit = x / divisor;
                var trailingDigit = x % 10;

                if (leadingDigit != trailingDigit)
                    return false;

                // Removing the leading and   
                // trailing digit from number 
                x = (x % divisor) / 10;

                // Reducing divisor by 
                // a factor of 2 as 2  
                // digits are dropped  
                divisor = divisor / 100;
            }
            return true;
        }
    }
}
 