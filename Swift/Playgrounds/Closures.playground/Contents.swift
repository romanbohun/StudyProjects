import UIKit

var sumClosure: (Int, Int) -> Int

//sumClosure = { (a: Int, b: Int) -> Int in
//    return a + b
//}

//sumClosure = { (a: Int, b: Int) -> Int in
//    a + b
//}

//sumClosure = { (a: Int, b: Int) in
//    a + b
//}

sumClosure = {
    $0 + $1
}


let result = sumClosure(2, 6)

let closureWithNoParameter: () -> String = {
    return "This is Closure with no parameters!!!"
}

print(closureWithNoParameter())


//let closureWithNoReturnValue: (a: Int) -> Void = { (argument: Int) in
//    print(argument * 5)
//}

let closureWithNoReturnValue: (_ a: Int) -> Void = {
    let res = $0 * 5
    print(res)
}


closureWithNoReturnValue(5)


let closureWithNoParametersAndNoReturnValues: () -> Void = {
    print("This is a closure with no Parameters and no Return values")
}

closureWithNoParametersAndNoReturnValues()
