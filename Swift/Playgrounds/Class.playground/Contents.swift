import UIKit


class KickBoxer {
    var name: String
    var punchPower: Int
    var punchSpeed: Int
    var kickPower: Int
    private var kickSpeed: Int
    
    init() {
        self.name = ""
        self.punchPower = 0
        self.punchSpeed = 0
        self.kickPower = 0
        self.kickSpeed = 0
    }
    
    init(name: String, punchPower: Int, punchSpeed: Int, kickPower: Int, kickSpeed: Int) {
        self.name = name
        self.punchPower = punchPower
        self.punchSpeed = punchSpeed
        self.kickPower = kickPower
        self.kickSpeed = kickSpeed
    }
    
    func kickBoxerIdentity() -> String {
        return "\(name), \(punchPower), \(punchSpeed), \(kickPower), \(kickSpeed)"
    }
}

var boxerA = KickBoxer(name: "A", punchPower: 200, punchSpeed: 300, kickPower: 400, kickSpeed: 500)
print(boxerA.kickPower)

var boxerB = KickBoxer(name: "B", punchPower: 300, punchSpeed: 600, kickPower: 200, kickSpeed: 100)
print(boxerB.punchSpeed)

var boxerC = boxerB

print(boxerA.kickBoxerIdentity())
print(boxerB.kickBoxerIdentity())
print(boxerC.kickBoxerIdentity())

boxerB.punchPower = 800

print(boxerB.punchPower)
print(boxerC.punchPower)

if boxerB === boxerC {
    print("Reffers to the same object in memory")
} else {
    print("Not reffer to the same object in memory")
}

// ----

struct Sport {
    var name: String
    let score: Int
}

class Athlete {
    let name: String
    private var sports: [Sport] = []
    
    init(name: String) {
        self.name = name
    }
    
    func addSport(sport: Sport) {
        self.sports.append(sport)
    }
    
    func getSportsValues () -> [Sport] {
        return self.sports
    }
}

let jack = Athlete(name: "Jack")
let boxing = Sport(name: "Boxing", score: 100)
let kickBoxing = Sport(name: "KickBoxing", score: 400)
jack.addSport(sport: boxing)
jack.addSport(sport: kickBoxing)
jack.getSportsValues()

let john = Athlete(name: "John")
john.addSport(sport: boxing)

john.getSportsValues()
