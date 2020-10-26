func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    var result = 0.0
    var grouped = [Int]()
    var indexFirst = 0
    var indexSecond = 0

    var continuation = true
    while continuation {

        if (indexFirst < nums1.endIndex && indexSecond < nums2.endIndex) {
            if (nums1[indexFirst] <= nums2[indexSecond]) {
                grouped.append(nums1[indexFirst])
                indexFirst += 1
            } else {
                grouped.append(nums2[indexSecond])
                indexSecond += 1
            }
        } else if (indexFirst < nums1.endIndex) {
            grouped.append(nums1[indexFirst])
            indexFirst += 1
        } else {
            grouped.append(nums2[indexSecond])
            indexSecond += 1
        }

        continuation = indexFirst < nums1.endIndex || indexSecond < nums2.endIndex
    }

//    var mid = grouped.endIndex / 2
//    print(grouped)
//    print(mid)
//    print(grouped.endIndex % 2)
    let mid = Int(grouped.endIndex / 2)
    if (grouped.endIndex % 2 == 1) {
        result = Double(grouped[mid])
    } else {
//        print((grouped[mid] + grouped[mid - 1]))
        result = Double(grouped[mid] + grouped[mid - 1]) / Double(2)
    }

    return result
}

findMedianSortedArrays([1,2], [3,4])
findMedianSortedArrays([1,3], [2])
findMedianSortedArrays([], [2])
findMedianSortedArrays([0,0], [0,0])
