import UIKit

var numberA: Int
numberA = 1

var numberB: Int?
numberB = nil
numberB = 2

print(numberB ?? 0)
type(of: numberB)

numberB! + 20

//---
let computerScreen: Optional<String> = Optional.none
let computerCPU: Optional<String> = Optional.some("Core i7")

print(computerScreen ?? "Nothing Found")
print(computerCPU)

switch computerCPU {
case Optional.none:
    print("No CPU")
case let Optional.some(value):
    print("our computer has a CPU \(value)")
}
