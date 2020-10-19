import Foundation

//Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].
//
///Example:
///
///Input:  [1,2,3,4]
///Output: [24,12,8,6]
///Constraint: It's guaranteed that the product of the elements of any prefix or suffix of the array (including the whole array) fits in a 32 bit integer.
///
///Note: Please solve it without division and in O(n).
///
///Follow up:
///Could you solve it with constant space complexity? (The output array does not count as extra space for the purpose of space complexity analysis.)

class ProductOfArrayExceptSelf {

    func productExceptSelf(_ nums: [Int]) -> [Int] {
        let length = nums.count
        guard length > 1 else { return nums }
        var output = Array<Int>.init(repeating: 1, count: length)

        var i = 0
        var tempValue = 1
        while i < length {
            output[i] = tempValue
            tempValue *= nums[i]
            i += 1
        }

        i = length - 1
        tempValue = 1
        while i >= 0 {
            output[i] *= tempValue
            tempValue *= nums[i]
            i -= 1
        }

        return output
    }

}

let productOfArray = ProductOfArrayExceptSelf()
let res1 = productOfArray.productExceptSelf([1,2,3,4])
let res2 = productOfArray.productExceptSelf([2,4,6,8])
