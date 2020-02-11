import UIKit

class Computer {
    
    var power: Int
    var speed: Int
    var ram: Int
    
    lazy var cpuPower: Int = {
        return (1000 * 2) + (2000 * 2) + (3000 * 2) + 1000
    }()
    
    var computerOverallValue: Int {
        return power * speed * ram + cpuPower
    }
    
    init(power: Int, speed: Int, ram: Int) {
        self.power = power
        self.speed = speed
        self.ram = ram
    }
}
