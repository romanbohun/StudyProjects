func removeDuplicates(_ nums: inout [Int]) -> Int {
    var result = 1

    guard nums.endIndex > 0 else {
        return nums.endIndex
    }

    var index = 0
    while index < nums.endIndex - 1  {
        print(nums.endIndex)
        if nums[index] == nums[index+1] {
            nums.remove(at: index+1)
        } else {
            result = result + 1
            index = index + 1
        }
    }

    return result
}

var arr = [1,1,2]
removeDuplicates(&arr)
