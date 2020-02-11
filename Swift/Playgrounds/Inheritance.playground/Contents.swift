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
}

class Lion: Animal {
    
    let canFight: Bool = true
}

let myAnimal = Animal(name: "My Animal", color: "Black", power: 200, speed: 400)
let myLion = Lion(name: "My Lion", color: "Yellow", power: 300, speed: 200)

print(myAnimal)
print(myLion)

print(myLion.canFight)
