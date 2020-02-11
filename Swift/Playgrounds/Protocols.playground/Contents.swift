import UIKit

protocol Boxing {
    
    func throwJab()
    func throwCross()
    func throwHook()
    func throwUppercut()
    
    var stamina: Int { get set } // Treat this one as var only
    var punchSpeed: Int { get } // Treat this one as var or let
    var punchPower: Int { get } // Treat this one as var or let
}


class Boxer: Boxing {
    
    var stamina: Int = 100
    
    // These are with get in protocol so can be with let here
    let punchSpeed: Int = 200
//    let punchPower: Int = 300
    
    // can be declared as a computed property
    var punchPower: Int {
        return stamina * punchSpeed
    }
    
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
}

let myBoxer = Boxer()
myBoxer.throwJab()
myBoxer.throwCross()
myBoxer.throwHook()
myBoxer.throwUppercut()

myBoxer.stamina = 400

//myBoxer.punchSpeed = 500


// ---
protocol KickBoxing: Boxing {
    
    func throwKick()
    
    var kickPower: Int { get }
    var kickSpeed: Int { get }
    
}

class KickBoxer: KickBoxing {
    
    var stamina: Int = 100
    let punchSpeed: Int = 200
    let punchPower: Int = 300
   
    var kickPower: Int = 400
    var kickSpeed: Int = 500
    
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
    
    func throwKick() {
        print("Kick")
    }
}

let myKickBoxer = KickBoxer()
myKickBoxer.throwJab()
myKickBoxer.throwKick()
myKickBoxer.throwCross()
myKickBoxer.throwHook()
myKickBoxer.throwUppercut()


protocol Computer {
    
    associatedtype RamType
    
    func turnOn()
    func turnOff()
    func OsName() -> String
    func canCalculateHeavyTasks() -> Bool
    
    func returnAmountOfRam() -> RamType
    
    var speed: Int { get }
    var power: Int { get }
}

class IPhone7: Computer {
    
    func turnOn() {
        print("Turn On")
    }
    
    func turnOff() {
        print("Turn Off")
    }
    
    func OsName() -> String {
        return "iOS"
    }
    
    func canCalculateHeavyTasks() -> Bool {
        return true
    }
    
    func returnAmountOfRam() -> Double {
        return 700.100
    }
    
    var speed: Int = 500
    var power: Int = 800
}

let myIphone = IPhone7()
print(myIphone.speed)
print(myIphone.power)
myIphone.turnOn()
myIphone.turnOff()
print(myIphone.OsName())
print(myIphone.canCalculateHeavyTasks())
print(myIphone.returnAmountOfRam())

protocol Screen {
    
    func TypeOfScreen() -> String
}

class GalaxyS6: Computer, Screen {
    
    func turnOn() {
        print("Turn On")
    }
    
    func turnOff() {
        print("Turn Off")
    }
    
    func OsName() -> String {
        return "Android"
    }
    
    func canCalculateHeavyTasks() -> Bool {
        return true
    }
    
    func returnAmountOfRam() -> Double {
        return 600
    }
    
    var speed: Int = 500
    var power: Int = 800
    
    func TypeOfScreen() -> String {
        return "Touch Screen"
    }
}


protocol ConvertIntToDouble {
    
    func convertToDouble() -> Double
}

extension Int: ConvertIntToDouble {
    
    func convertToDouble() -> Double {
        return Double(self)
    }
}

22.convertToDouble()
print(23.convertToDouble())


// Protocols are used for classes, structs, enums
// as for enums, properties must be implemented as computed only

enum BoxerEnum: Boxing {
    
    case Amateur
    case Professional
    
    var stamina: Int {
        
        get {
            
            switch self {
            case .Amateur:
                return 1000
            case .Professional:
                return 2000
            }
        }
        
        set {
            
        }
    }
    
    var punchSpeed: Int {
        return 3000
    }
    
    var punchPower: Int {
        return 2500
    }
    
    func throwJab() { print("Enum boxer JAB")}
    func throwCross() {}
    func throwHook() {}
    func throwUppercut() {}
    
}

var myBoxer2: Boxing
myBoxer2 = BoxerEnum.Amateur
myBoxer2.throwJab()
myBoxer2 = Boxer()
myBoxer2.throwJab()


// ---
protocol Artist {
    
    var name: String { get }
    var art: String { get }
    var years: Int { get }
    
    func performArt()
}

class Actor: Artist {
    
    var name: String
    var art: String
    var years: Int
    
    init(name: String, art: String, years: Int) {
        self.name = name
        self.art = art
        self.years = years
    }
    
    func performArt() {
        print("Performance of \(name) is \(art)")
    }
}

let myActor = Actor(name: "My Actor", art: "Acting", years: 36)
myActor.performArt()

class Singer: Artist {
    
    var name: String
    var art: String
    var years: Int
    
    init(name: String, art: String, years: Int) {
        self.name = name
        self.art = art
        self.years = years
    }
    
    func performArt() {
        print("Performance of \(name) is \(art)")
    }
}

let mySinger = Singer(name: "My Singer", art: "Singing", years: 46)
mySinger.performArt()

var artists: Array<Artist> = [Actor(name: "M", art: "Acting", years: 25), myActor, mySinger]

func printNameAndArtOfArtists(artists: Array<Artist>) {
    
    for artist in artists {
        artist.performArt()
    }
}

printNameAndArtOfArtists(artists: artists)


//
// Equatable
extension Actor: Equatable {
    public static func == (lhs: Actor, rhs: Actor) -> Bool {
        return lhs.name == rhs.name && lhs.art == rhs.art
    }
}

let myActor2 = Actor(name: "My Actor2", art: "Acting", years: 29)
myActor == myActor2


// Comparable
extension Actor: Comparable {
    public static func < (lhs: Actor, rhs: Actor) -> Bool {
        return lhs.years < rhs.years
    }
}
myActor < myActor2

let myActor3 = Actor(name: "M", art: "Acting", years: 25)
var artists2: Array<Actor> = [myActor3, myActor, myActor2]
artists2.sorted()

artists2.min()
artists2.max()


artists2.starts(with: [myActor])
artists2.starts(with: [myActor3, myActor])
artists2.contains(myActor2)

extension Actor: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

let actorDict: [String : Actor] = [myActor.name : myActor, myActor2.name : myActor2, myActor3.name : myActor3]
let actorDict2: [Actor : String] = [myActor : myActor.name]

print(actorDict2)


let mobileSet: Set<Actor> = [myActor, myActor2, myActor3, myActor, myActor2]


protocol CustomBooleanType {
    var booleanValue: Bool { get }
}

extension Actor: CustomBooleanType {
    var booleanValue: Bool {
        return self.years > 35
    }
}


extension Actor: CustomStringConvertible {
    
    var description: String {
        return "\(self.name) - \(self.art) - \(self.years)"
    }
}

print(myActor)
