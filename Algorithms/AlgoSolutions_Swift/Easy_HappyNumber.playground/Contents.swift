import Foundation

///Write an algorithm to determine if a number is "happy".
///
///A happy number is a number defined by the following process: Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process ends in 1 are happy numbers.

///Input: 19
///Output: true
///Explanation:
///1^2 + 9^2 = 82
///8^2 + 2^2 = 68
///6^2 + 8^2 = 100
///1^2 + 0^2 + 02 = 1

class HappyNumber {

    /// The best solution - under the 8ms
    func isHappy(_ n: Int) -> Bool {
        var num = n
        var sum = 0

        while (num >= 0) {
            let operatedDigit = num % 10
            sum += Int(pow(Double(operatedDigit), Double(2)))
            num /= 10

            if num == 0 {
                if sum > 1 && sum != 4 {
                    num = sum
                    sum = 0
                } else if sum == 1 {
                    return true
                } else {
                    return false
                }
            }
        }
        return false
    }

    func isHappy3(_ n: Int) -> Bool {
        var num = n

        while (num >= 0) {
            let sumSlow = getTheSum(num)
            let sumFast = getTheSum(getTheSum(num))

            if sumFast > 1 && sumFast != 4{
                num = sumFast
            } else if sumFast == 1 {
                return true
            } else {
                if sumSlow > 1 && sumSlow != 4{
                    num = sumSlow
                } else if sumSlow == 1 {
                    return true
                } else {
                    return false
                }
            }
        }
        return false
    }

    func isHappy4(_ n: Int) -> Bool {
        var num = n

        while true {
            let sum = getSum(num)
            if sum > 1 && sum != 4 {
                num = sum
            } else if sum == 1 {
                return true
            } else {
                return false
            }
        }
    }

    private func getTheSum(_ input: Int) -> Int {
        var num = input
        var sum = 0;

        while (num != 0) {
            let operatedDigit = num % 10
            sum += Int(pow(Double(operatedDigit), Double(2)))
            num /= 10
        }

        return sum
    }

    func isHappy2(_ n: Int) -> Bool {
        var num = n
        var sum = 0

        while true {
            sum = getSum(num)
            if sum > 1 {
                num = sum
                sum = 0
            } else if sum == 1 {
                return true
            } else {
                return false
            }
        }
    }
    private func getSum(_ inputValue: Int) -> Int {
        return String(inputValue).compactMap { $0.wholeNumberValue! * $0.wholeNumberValue! }.reduce(0, +)
    }
}

let happy = HappyNumber()
let res1 = happy.isHappy4(1111111)
let res2 = happy.isHappy4(19)
