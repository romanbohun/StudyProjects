
func mergeArrays(array1: [Int], array2: [Int]) -> [Int] {
    if array1.isEmpty {
        return array2
    } else if (array2.isEmpty) {
        return array1
    }
    
    var result = [Int]()
    var i = 0
    var j = 0
    var array1Item: Int? = array1[i]
    var array2Item: Int? = array2[j]
    
    while (array1Item != nil || array2Item != nil) {
        if let item1 = array1Item,
            let item2 = array2Item,
            item1 < item2 {
            result.append(item1)
            i += 1
            array1Item = i < array1.endIndex ? array1[i] : nil
        } else if let item2 = array2Item {
            result.append(item2)
            j += 1
            array2Item = j < array2.endIndex ? array2[j] : nil
        }
    }
    
    return result
}

mergeArrays(array1: [0, 3, 4, 30], array2: [4, 6, 31])
