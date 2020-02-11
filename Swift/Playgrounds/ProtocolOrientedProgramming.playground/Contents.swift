import UIKit

protocol Boxing {
    
    func throwJab()
    func throwCross()
    func throwHook()
    func throwUppercut()
    
    func someCalculations() -> Int
    
    var stamina: Int { get set } // Treat this one as var only
    var punchSpeed: Int { get } // Treat this one as var or let
    var punchPower: Int { get } // Treat this one as var or let
}

extension Boxing {
    
    func throwJab() {
        print("Jab")
    }
    
    func throwCross() {
        print("Cross")
    }
    
    func throwHook() {
        print("Hook")
    }
    
    func throwUppercut() {
        print("Uppercut")
    }
    
    func dsfjsdf() {
        
    }
    
    func someCalculations() -> Int {
        return 300
    }
    
    var punchSpeed: Int {
        return 500
    }
}

class Boxer: Boxing {
    var stamina: Int = 100
//    var punchSpeed: Int = 200
    var punchPower: Int = 300
    
    func throwJab() {
        print("Boxer Jab")
    }
    
    func someCalculations() -> Int {
        return 600
    }
}

protocol KickBoxing {
    var kickPower: Int { get }
    var kickSpeed: Int { get }
    
    func calculateOverallValueOfKickBoxer() -> Int
}

extension KickBoxing where Self: Boxing {
    func calculateOverallValueOfKickBoxer() -> Int {
        return (stamina * punchPower * punchSpeed) + (kickSpeed * kickPower)
    }
}

class KickBoxer: Boxing, KickBoxing {
    var stamina: Int = 100
    var punchSpeed: Int = 200
    var punchPower: Int = 300
    
    var kickPower: Int = 400
    var kickSpeed: Int = 500
}

let myBoxer: Boxing = Boxer()
let kickBoxer = KickBoxer()

myBoxer.throwJab()
kickBoxer.throwJab()

print(myBoxer.punchSpeed)
print(kickBoxer.punchSpeed)

print(myBoxer.someCalculations())
