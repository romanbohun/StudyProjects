using System;
using System.Collections.Generic;

namespace AlgorythmProblemSolutions.Easy
{
    public static class TwoSumSolutions
    {
        // Non-sorted array
        // Possible inputs:
        // TwoSum(new int[] { 2, 7, 11, 15 }, 9)
        // TwoSum(new int[] { 3, 2, 3 }, 6)
        // Outputs:
        // [0, 1]
        // [0, 2]
        public static int[] TwoSum(int[] nums, int target)
        {
            var prevNumStorage = new Dictionary<int, int>();
            for (int i = 0; i < nums.Length; i++)
            {
                var currentValue = nums[i];
                var odd = target - currentValue;
                if (prevNumStorage.ContainsKey(odd))
                {
                    return new int[] { prevNumStorage[odd], i };
                }
                else
                {
                    prevNumStorage[currentValue] = i;
                }
            }
            return new int[0];
        }

        // Array is sorted in ascending order
        // Possible inputs:
        // TwoSum2(new int[] { 2, 7, 11, 15 }, 9)
        // TwoSum2(new int[] { 2,3,4 }, 6)
        // Output:
        // [1, 2]

        public static int[] TwoSum2(int[] numbers, int target)
        {
            var startIndex = 0;
            var endIndex = numbers.Length - 1;

            while (startIndex < endIndex)
            {
                if (numbers[startIndex] + numbers[endIndex] == target)
                {
                    return new int[] { startIndex + 1, endIndex + 1 };
                }
                else if (numbers[startIndex] + numbers[endIndex] > target)
                {
                    endIndex--;
                }
                else
                {
                    startIndex++;
                }
            }
            return new int[0];
        }

    }
}
