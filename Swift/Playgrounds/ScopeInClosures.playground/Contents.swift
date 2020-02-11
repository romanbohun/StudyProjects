import UIKit

var numberA = 1

let multiplyNumberA = {
    numberA *= 2
}

multiplyNumberA()
multiplyNumberA()

numberA


func multiply() -> (() -> Double) {
    var number: Double = 1.0
    
    let multiplyClosure: () -> Double = {
        number *= 3
        return number
    }
    
    return multiplyClosure
}

let resultA = multiply()
resultA()
resultA()
