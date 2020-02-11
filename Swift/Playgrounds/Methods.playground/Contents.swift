import UIKit

struct Calculation {
    let firstNumber: Int
    let secondNumber: Int
    
    init(_ firstNumber: Int, _ secondNumber: Int) {
        self.firstNumber = firstNumber
        self.secondNumber = secondNumber
    }
    
    func Sum() -> Int {
        return firstNumber + secondNumber
    }
    
    func Subsctruction() -> Int {
        return firstNumber - secondNumber
    }
    
    func Multiplication() -> Int {
        return firstNumber * secondNumber
    }
    
    func Division() -> Int {
        return secondNumber == 0 ? 0 : firstNumber / secondNumber
    }
}

let calc1 = Calculation(100, 5)
calc1.Sum()
calc1.Subsctruction()
calc1.Multiplication()
calc1.Division()

