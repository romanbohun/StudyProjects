func search(_ nums: [Int], _ target: Int) -> Int {

    // var 1 -----
//    let mid = nums.count / 2
//
//    let result1 = search2(nums, target, 0, mid)
//    let result2 = search2(nums, target, mid, nums.endIndex)
//
//    if let r1 = result1 {
//        return r1
//    } else if let r2 = result2 {
//        return r2
//    }
    // var 1 -----

    if let r = search2(nums, target, 0, nums.endIndex - 1) {
        return r
    }
    return -1
}

func search2(_ nums: [Int], _ target: Int, _ startIndex: Int, _ endIndex: Int) -> Int? {
    guard startIndex <= endIndex else {
        return nil
    }

    print("\(startIndex) -- \(endIndex)")
    // var 2 ------
    if nums[startIndex] == target {
        return startIndex
    } else if nums[endIndex] == target {
        return endIndex
    }

    let startIndex2 = startIndex + 1
    let endIndex2 = endIndex - 1

    let mid = startIndex2 + ((endIndex2 - startIndex2) / 2)

    if nums[mid] == target {
        return mid
    }

    let result1 = search2(nums, target, startIndex2, mid)
    let result2 = search2(nums, target, mid, endIndex2)

    if let r1 = result1 {
        return r1
    } else if let r2 = result2 {
        return r2
    }

    // var 2 ------


    // var 1 -----
//    for item in startIndex...endIndex - 1 {
//        if nums[item] == target {
//            return item
//        }
//    }

    // var 1 -----
    return nil
}

//search([4,5,6,7,0,1,2], 0)
//search([4,5,6,7,0,1,2], 3)
//search([1], 0)
//search([1], 1)
