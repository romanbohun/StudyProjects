func plusOne(_ digits: [Int]) -> [Int] {
    var result = digits

    var currentIndex = digits.count - 1
    var extraNum = 1

    while currentIndex >= 0 {
        let dig = digits[currentIndex] + extraNum
        print(dig)
        if dig == 10 {
            extraNum = 1
            result[currentIndex] = 0
        } else {
            extraNum = 0
            result[currentIndex] = dig
            return result
        }

        currentIndex -= 1
    }

    if extraNum > 0 {
        result.insert(extraNum, at: 0)
    }
    return result
}


//plusOne([1,2,3])
//plusOne([4,3,2,1])
//plusOne([9])
//plusOne([0])
