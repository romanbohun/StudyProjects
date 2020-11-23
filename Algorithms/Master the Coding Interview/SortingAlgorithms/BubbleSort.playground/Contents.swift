var numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0];

//func bubbleSort(_ array: inout [Int]) {
//    var i = 0
//    var j = 1
//    let overallCount = array.count - 1
//    var condition = true
//    while condition {
//        if (array[i] > array[j]) {
//            let tmp = array[i]
//            array[i] = array[j]
//            array[j] = tmp
//        }
//
//        if (j == overallCount && i <= overallCount) {
//            i += 1
//            j = i
//        } else {
//            j += 1
//        }
//
//        condition = i != overallCount
//    }
//}

func bubbleSort(_ array: inout [Int]) {
    var i = 0
    let lenth = array.count - 1
    var overallCount = array.count - 1
    while overallCount >= 0 {
        if (array[i] > array[i+1]) {
            let tmp = array[i]
            array[i] = array[i+1]
            array[i+1] = tmp
        }

        i += 1

        if (i == lenth) {
            i = 0
            overallCount -= 1
        }
    }
}

bubbleSort(&numbers);
print(numbers);
