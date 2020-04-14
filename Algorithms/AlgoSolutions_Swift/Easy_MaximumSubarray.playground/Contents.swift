//Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.
//
///Example:
///
///Input: [-2,1,-3,4,-1,2,1,-5,4],
///Output: 6
///Explanation: [4,-1,2,1] has the largest sum = 6.
///Follow up:
///
///If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.

class MaximumSubarray {

    // The worst solution
    func maxSubArray(_ nums: [Int]) -> Int {
        let length = nums.count
        if length == 1 {
            return nums[0]
        }

        var resultSum = Int.min
        var milestoneSum = 0

        var i = 0
        var j = 0
        while i < length {
            j = i + 1
            milestoneSum += nums[i]

            if resultSum < milestoneSum {
                resultSum = milestoneSum
            }

            while j < length {
                milestoneSum += nums[j]
                j += 1
                if resultSum < milestoneSum {
                    resultSum = milestoneSum
                }
            }
            milestoneSum = 0
            i += 1
        }

        return resultSum
    }

    // Fast solution by Devide and conquer
    func maxSubArray2(_ nums: [Int]) -> Int {
        let length = nums.count
        if length == 1 {
            return nums[0]
        }

        let resultSum = maxSubarraySum(nums, 0, length - 1)
        return resultSum
    }

    private func maxCrossingSum(_ array: [Int], _ low: Int, _ middle: Int, _ high: Int) -> Int {
        var sum = 0
        var sumLeft = Int.min
        var i = middle
        while (i >= low) {
            sum += array[i]
            if (sumLeft < sum) {
                sumLeft = sum
            }
            i -= 1
        }

        sum = 0
        var sumRight = Int.min
        i = middle + 1
        while (i <= high) {
            sum += array[i]
            if (sumRight < sum) {
                sumRight = sum
            }
            i += 1
        }

        return sumLeft + sumRight
    }


    private func maxSubarraySum(_ array: [Int], _ low: Int, _ high: Int) -> Int {
        if (low == high) {
            return array[low]
        }

        let middle = (low + high) / 2
        return max(max(maxSubarraySum(array, low, middle), maxSubarraySum(array, middle+1, high)),maxCrossingSum(array, low, middle, high))
    }

    func maxSubArray3(_ nums: [Int]) -> Int {
        let length = nums.count
        if length == 1 {
            return nums[0]
        }

        var resultSum = nums[0]
        var previous = 0
        for i in 0...length - 1 {
            let sumOfTwos = previous + nums[i]
            previous = max(sumOfTwos, nums[i])
            resultSum = max(resultSum, previous)
        }

        return resultSum
    }
}
