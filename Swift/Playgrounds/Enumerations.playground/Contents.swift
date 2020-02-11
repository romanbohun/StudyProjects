import UIKit

enum Animal {
    case Lion
    case Tiger
    case Horse
    case Cat
    case Monkey
    case Panther
}

enum Animal2: Int {
    case Lion, Tiger, Horse, Cat, Monkey, Panther
}

//---
enum Sport: Int {
    case Boxing = 20, kickBoxing = 50, Judo = 100, Jujitsu = 200, AiKido = 12
}

var kickB = Sport(rawValue: 50)
print(kickB)

//---
enum PersonGender: Int {
    case male = 1
    case female = 2
}

let male = PersonGender.male
male.rawValue

let female = PersonGender.female
female.rawValue

//---
enum OutCome {
    case victory(String)
    case failure(String)
}

func evaluateSport(sport: Sport) -> OutCome {
    switch sport {
    case .Boxing:
        return .victory("Awesomeeeee")
    default:
        return .failure("Bad")
    }
}

let t = evaluateSport(sport: Sport.Boxing)

switch t {
case .victory(let result):
    print("Victory: \(result)")
case .failure(let result):
    print("Failure: \(result).")
}

