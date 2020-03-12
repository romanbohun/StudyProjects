func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var numStorage = Dictionary<Int, Int>()
    for (index, item) in nums.enumerated() {
        let odd = target - item
        if let oddIndexInStorage = numStorage[odd] {
            return [oddIndexInStorage, index]
        } else {
            numStorage[item] = index
        }
    }
    return []
}

twoSum([2,7,11,15], 9)
twoSum([3,2,3], 6)
