import UIKit

import UIKit

class Animal {
    let name: String
    let color: String
    var power: Int
    var speed: Int
    
    init(name: String, color: String, power: Int, speed: Int) {
        self.name = name
        self.color = color
        self.power = power
        self.speed = speed
    }
    
    func increasePower () {
        self.power += 1
    }
}

class Dog: Animal {
    let canFight = true
    
    override func increasePower() {
        self.power += 2
    }
}

let animal = Animal(name: "Catdog", color: "Red", power: 40, speed: 11)
let dog = Dog(name: "Jack", color: "Black", power: 25, speed: 12)

print(animal.power)
print(dog.power)

animal.increasePower()
dog.increasePower()

print(animal.power)
print(dog.power)
