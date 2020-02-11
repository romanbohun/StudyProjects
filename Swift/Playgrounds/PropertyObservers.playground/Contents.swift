import UIKit

class Lion {
    let name: String
    var power: Int
    var speed: Int
    var age: Int
    var canFight: Bool = false {
        
        //These obeservers are not run during instantiating an object
        willSet {
            print("willSet -> \(newValue)")
        }
        
        didSet {
            print("didSet -> \(oldValue)")
        }
    }
    
    init(name: String, power: Int, speed: Int, age: Int) {
        self.name = name
        self.power = power
        self.speed = speed
        self.age = age
    }
}


var myLion = Lion(name: "MyLion", power: 200, speed: 400, age: 15)

myLion.canFight = true
