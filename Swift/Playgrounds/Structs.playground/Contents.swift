import UIKit

struct Computer {
    var power: Int
    var speed: Int
    var ram: Int
    let cpu: String
    let screenSize: Int
}

var cA = Computer(power: 2000, speed: 1000, ram: 16000, cpu: "Core i7", screenSize: 15)
var cB = Computer(power: 1000, speed: 500, ram: 1000, cpu: "Mediatec", screenSize: 5)

struct DesktopComputer {
    var computer: Computer
    let name: String
    var hasTouchPad: Bool
}

var myDC = DesktopComputer(computer: cA, name: "Macbook Pro", hasTouchPad: true)

struct MobileComputer {
    var computer: Computer
    let name: String
    var hasTouchScreen: Bool
}

var myMC = MobileComputer(computer: cB, name: "iPhone7", hasTouchScreen: true)

//Initialization

struct Computer2 {
    
    var power: Int
    var speed: Int
    var ram: Int
    let cpu: String
    let screenSize: Int?
    
    init(power: Int, speed: Int, ram: Int, cpu: String, screenSize: Int) {
        self.power = power
        self.speed = speed
        self.ram = ram
        self.cpu = cpu
        self.screenSize = screenSize
    }
    
    init?(screenSize: Int) {
        
        if (screenSize == 0) {
            return nil
        }
        
        self.screenSize = screenSize
        self.cpu = ""
        self.power = 0
        self.speed = 0
        self.ram = 0
    }
    
    init() {
        self.cpu = ""
        self.power = 0
        self.speed = 0
        self.ram = 0
        self.screenSize = 0
    }
}

let c2 = Computer2(screenSize: 15)
print(c2)

let c3 = Computer2(screenSize: 0)
print(c3)

let c4 = Computer2()
print(c4)

if let c2Unwrapped = c2 {
    print(c2Unwrapped)
}
