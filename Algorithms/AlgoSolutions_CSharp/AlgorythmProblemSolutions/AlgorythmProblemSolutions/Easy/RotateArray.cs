using System;
namespace AlgorythmProblemSolutions.Easy
{
    public static class RotateArray
    {
        public static void Rotate(int[] nums, int k)
        {
            var output = new int[nums.Length];

            //for (int i = nums.Length - k; i < nums.Length; i++)
            //{
            //    output[nums.Length - k - i] = nums[i];
            //}

            for (int i = 0; i < nums.Length - (k+1); i++)
            {
                output[i] = nums[i+k+1];
            }

            var index = k;
            for (int i = 0; i < nums.Length - k; i++)
            {
                output[index] = nums[i];
                index++;
            }

            for (int i = 0; i < nums.Length; i++)
            {
                nums[i] = output[i];
            }
            //while (k != 0)
            //{
            //    k--;
            //    var temp = nums[k];
            //    nums[k] = nums[nums.Length - ++k];
            //    nums[nums.Length - k] = temp;
            //    k--;
            //}
        }
    }
}
