var numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0];

func insertionSort(_ array: inout [Int]) {
    for index in 1..<array.count
    {
        let value = array[index]
        var position = index

        print("- Inspecting value: \(value) at position: \(position)")

        while position > 0 && array[position - 1] > value
        {
            print("-- \(array[position-1]) > \(value), so shifting \(array[position-1]) to the right")

            array[position] = array[position - 1]
            position -= 1

            print("-> \(array)")
        }

        print("-- Found sorted position of \(value) is \(position), so inserting")

        array[position] = value

        print("-> \(array)")
        print("")
    }
}

insertionSort(&numbers);
print(numbers);
