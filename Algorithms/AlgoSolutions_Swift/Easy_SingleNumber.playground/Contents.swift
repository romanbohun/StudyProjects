import Foundation

//Given a non-empty array of integers, every element appears twice except for one. Find that single one.
///
///Note:
///
///Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?
///
///Example 1:
///
///Input: [2,2,1]
///Output: 1
///Example 2:
///
///Input: [4,1,2,1,2]
///Output: 4

public class SingleNumber {

    public func singleNumber(_ nums: [Int]) -> Int {
        let length = nums.count
        if length == 1 {
            return nums[0]
        }

        var storage: Dictionary<Int, Int> = Dictionary<Int, Int>()
        for item in nums {
            if storage[item] == nil {
                storage[item] = 1
            } else {
                storage[item]? += 1
            }
        }

        return storage.first { _, value in
            value == 1
            }!.key
    }

    /// The best one (is not mine)
    /// Bitwise XOR is used here
    public func singleNumber2(_ nums: [Int]) -> Int {
        var x = 0
        for i in 0..<nums.count{
            x ^= nums[i]
        }
        return x
    }
    
}


let single = SingleNumber()
single.singleNumber2([2,2,1])
single.singleNumber2([4,1,2,1,2])
single.singleNumber2([1,3,1,-1,3])
