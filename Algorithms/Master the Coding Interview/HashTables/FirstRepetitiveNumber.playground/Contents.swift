import Foundation

func getFirstRepetitiveNumber(array: [Int]) -> Int? {
    var intSet = Set<Int>(minimumCapacity: array.endIndex + 1)
    for item in array {
        if intSet.contains(item) {
            return item
        } else {
            intSet.insert(item)
        }
    }
    return nil
}

getFirstRepetitiveNumber(array: [2,5,2,1,3,5,1,2,4])
getFirstRepetitiveNumber(array: [2,1,1,2,3,5,1,2,4])
getFirstRepetitiveNumber(array: [2,3,4,5])
getFirstRepetitiveNumber(array: [])
