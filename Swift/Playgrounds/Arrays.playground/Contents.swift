import UIKit

let intValues: Array<Int>

var integerNumbersA = Array<Int>()

let integerNumbersB = [Int]()


intValues = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

integerNumbersA = [Int](repeating: 30, count: 10)

let englishAlphabet: Array<String> = ["A", "B", "C", "D", "E", "F", "G"]

let stringvalues = ["iOS", "Android", "Windows"]



var intValues2 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var animalNames = ["Africal Lion", "Fox", "Bear", "Tiger"]

if intValues2.count > 5 {
    print("We have more than 5 Integer values")
} else {
    print("We have less than 5 Integer values")
}

print(intValues2.first)
print(intValues2.last)
print(intValues2.max())
print(intValues2.min())

print(animalNames.first)
print(animalNames.last)
print(animalNames.max())
print(animalNames.min())
