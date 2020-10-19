func maxArea(_ height: [Int]) -> Int {
    var result = 0

    var leftIndex = 0
    var rightIndex = height.endIndex - 1

    while leftIndex < rightIndex {
        let leftValue = height[leftIndex]
        let rightValue = height[rightIndex]

        let minItem = min(leftValue, rightValue)
        let res = minItem * (rightIndex - leftIndex)

        if result < res {
            result = res
        }

        if (leftValue < rightValue) {
            leftIndex = leftIndex + 1
        } else {
            rightIndex = rightIndex - 1
        }
    }

    return result
}

// 2
//maxArea([1,2,1])
// 16
//maxArea([4,3,2,1,4])
// 49
//maxArea([1,8,6,2,5,4,8,3,7])
