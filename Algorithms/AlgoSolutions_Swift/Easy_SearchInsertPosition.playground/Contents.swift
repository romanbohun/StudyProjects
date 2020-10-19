func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    guard nums.endIndex > 0 else {
        return 0
    }

    for item in nums.enumerated() {
        if item.element > target {
            return item.offset
        } else if (item.element == target) {
            return item.offset
        }
    }

    return nums.endIndex
}

searchInsert([1], 0)
