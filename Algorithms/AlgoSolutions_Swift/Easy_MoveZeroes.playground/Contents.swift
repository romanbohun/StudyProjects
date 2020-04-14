import Foundation

//Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.
//
///Example:
///
///Input: [0,1,0,3,12]
///Output: [1,3,12,0,0]
///Note:
///
///1.You must do this in-place without making a copy of the array.
///2.Minimize the total number of operations.

class MoveZeroes {

    // Not so bad, in the middle 40ms - beats more than 86 submissions
    func moveZeroes(_ nums: inout [Int]) {
        let length = nums.count
        if length == 1 {
            return
        }

        var zeroCount = 0
        var i = 0
        while (i < length - zeroCount) {
            if nums[i] == 0 {
                zeroCount += 1
                nums.remove(at: i)
            } else {
                i += 1
            }
        }

        nums.append(contentsOf: [Int](repeatElement(0, count: zeroCount)))
    }

    // The best solution - 28ms - beats 100% submissions
    func moveZeroes2(_ nums: inout [Int]) {
        let length = nums.count
        if length == 1 {
            return
        }

        var i = 0
        var moveIndex = 0
        while (i < length) {
            if nums[i] != 0 {
                let temp = nums[moveIndex]
                nums[moveIndex] = nums[i]
                nums[i] = temp
                moveIndex = moveIndex + 1
            }

            i += 1
        }
    }
}

let moveZeroes = MoveZeroes()
var array1 = [0,1,0,3,12]
var array2 = [0,0,1]
var array3 = [1,0,1]
var array4 = [1,2]
moveZeroes.moveZeroes2(&array)
