import UIKit

var numberA = 20
var numberB = numberA

print(numberA)
print(numberB)

// ----
print("----")

struct KickBoxer {
    
    var punchSpeed: Int
    var punchPower: Int
    var kickSpeed: Int
    var kickPower: Int
    
    init(punchSpeed: Int, punchPower: Int, kickSpeed: Int, kickPower: Int) {
        self.punchSpeed = punchSpeed
        self.punchPower = punchPower
        self.kickSpeed = kickSpeed
        self.kickPower = kickPower
    }
}

var kickBoxerA = KickBoxer(punchSpeed: 10, punchPower: 20, kickSpeed: 15, kickPower: 30)
print(kickBoxerA.kickPower)

var kickBoxerB = KickBoxer(punchSpeed: 20, punchPower: 35, kickSpeed: 30, kickPower: 45)
print(kickBoxerB.punchSpeed)


var kickBoxerC = kickBoxerB
kickBoxerB.kickPower = 50
print(kickBoxerC)
