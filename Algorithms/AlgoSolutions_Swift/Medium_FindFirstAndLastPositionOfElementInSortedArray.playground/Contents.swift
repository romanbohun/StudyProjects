func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
    guard nums.endIndex != 0 else {
        return [-1,-1]
    }

    var firstIndex = -1
    var lastIndex = -1

    var leftIndex = 0
    var rightIndex = nums.endIndex - 1

    while true {
        if firstIndex < 0 && nums[leftIndex] == target {
            firstIndex = leftIndex
        } else {
            leftIndex += 1
        }

        if lastIndex < 0 && nums[rightIndex] == target {
            lastIndex = rightIndex
        } else {
            rightIndex -= 1
        }

        if (firstIndex > -1 && lastIndex > -1) ||
            leftIndex > nums.endIndex ||
            rightIndex < 0 {
            break;
        }
    }

    return [firstIndex, lastIndex]
}

//searchRange([], 0)
//searchRange([5,7,7,8,8,10], 6)
searchRange([5,7,7,8,8,10], 8)
//searchRange([1], 1)
//searchRange([1,3], 1)
