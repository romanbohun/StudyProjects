func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var result = [Int]()
    var previousItem = 0
    var previousIndex = -1
    for (index, item) in nums.enumerated() {
        if previousItem == target - item {
            if previousIndex >= 0 {
                result.append(previousIndex)
            }
            result.append(index)
            break
        }
        previousItem = itesm
        previousIndex = index
    }
    
    return result
}

twoSum([2,7,11,15], 9)
