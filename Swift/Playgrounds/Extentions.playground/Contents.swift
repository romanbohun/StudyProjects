import UIKit

struct Boxing {
    
    var punchSpeed: Int
    var punchPower: Int
    var stamina: Int
    
    init(punchSpeed: Int, punchPower: Int, stamina: Int) {
        self.punchSpeed = punchSpeed
        self.punchPower = punchPower
        self.stamina = stamina
    }
    
    mutating func increasePunchPower() -> Void {
        self.punchPower += 5
    }
}

extension Boxing {
    mutating func increasePunchSpeed() {
        self.punchSpeed += 10
    }
    
    mutating func increaseStamina() {
        self.stamina += 6
    }

}

var boxing = Boxing(punchSpeed: 8, punchPower: 15, stamina: 7)
print(boxing)

boxing.increasePunchPower()
print(boxing)

boxing.increasePunchSpeed()
print(boxing)

boxing.increaseStamina()
print(boxing)


//To system types

extension String {
    func shortOrLongStringValue() -> String {
        if self.count > 5 {
            return "Long String value"
        } else {
            return "Short String value"
        }
    }
}

"12345".shortOrLongStringValue()
"123456".shortOrLongStringValue()
