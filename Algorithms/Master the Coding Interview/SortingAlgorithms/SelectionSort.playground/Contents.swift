var numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0];

func selectionSort(_ array: inout [Int]) {
    var i = 0
    var j = 0
    let lenth = array.count

    while i < lenth {

        j = i + 1
        var minIndex = i
        let tmpValue = array[i]
        while j < lenth {
            if (array[j] < array[minIndex]) {
                minIndex = j
            }
            j += 1
        }

        array[i] = array[minIndex]
        array[minIndex] = tmpValue
        i += 1
    }
}

selectionSort(&numbers);
print(numbers);
