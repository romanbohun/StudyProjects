import UIKit

struct Boxer {
    
    var name: String
    var speed: Int
    var power: Int
}

struct Coach<T> {
    
    var name: String
    
    var martialArtsType: T
}

let coachA = Coach(name: "Coach A", martialArtsType: Boxer(name: "Boxer A", speed: 50, power: 80))
coachA.martialArtsType.power


//enum OptionalPunchSpeed {
//    case None
//    case Some(Int)
//}
//
//enum OptionalPunchPower {
//    case None
//    case Some(Int)
//}
//
//enum OptionalStamina {
//    case None
//    case Some(Int)
//}


func combinedString<T1, T2>(first: T1, second: T2) -> String {
    return "\(first) \(second)"
}

combinedString(first:"iOS", second: "develoepr")
