import Foundation

func findCommonItems(firstArray: [String], secondArray: [String]) -> [String] {
    var set = Set<String>()
    firstArray.forEach { item in
        set.insert(item)
    }
    
    var result = [String]()
    
    secondArray.forEach { item in
        if set.contains(item) {
            result.append(item)
        }
    }
    return result
}

let array1 = ["a","b","c","x"]
let array2 = ["d","f","x","a"]

findCommonItems(firstArray: array1, secondArray: array2)
