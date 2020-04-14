import Foundation

//Given a binary array, find the maximum length of a contiguous subarray with equal number of 0 and 1.
///
///Example 1:
///Input: [0,1]
///Output: 2
///Explanation: [0, 1] is the longest contiguous subarray with equal number of 0 and 1.
///
///Example 2:
///Input: [0,1,0]
///Output: 2
///Explanation: [0, 1] (or [1, 0]) is a longest contiguous subarray with equal number of 0 and 1.
///
///Note: The length of the given binary array will not exceed 50,000.

class ContiguousArray {

    func findMaxLength(_ nums: [Int]) -> Int {
        let length = nums.count
        guard length > 1 else { return 0 }

        var current = 0
        var map: [Int : Int] = [0 : -1]
        var i = 0
        var indexCount = 0

        while i < length {
            current += nums[i]  == 0 ? -1 : 1

            if let mapValue = map[current] {
                indexCount = max(indexCount, i - mapValue)
            } else {
                map[current] = i
            }
            i += 1
        }
        return indexCount
    }

}


let ctgArray = ContiguousArray()
let res1 = ctgArray.findMaxLength([0, 1])
let res2 = ctgArray.findMaxLength([0, 1, 0])
let res3 = ctgArray.findMaxLength([0, 1, 0, 1])
let res4 = ctgArray.findMaxLength([0, 1, 1])
let res5 = ctgArray.findMaxLength([0, 0, 0, 1, 1, 1, 0])
