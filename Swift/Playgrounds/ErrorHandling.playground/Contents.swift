import UIKit

enum BoxingError : Error {
    
    case NotEnoughPowerError
    case NotEnoughSpeedError
    
}

protocol Boxing {
    var power: Int { get }
    var speed: Int { get }
    
    func makeJab() -> Bool
}

class Boxer: Boxing {
    
    var power: Int
    var speed: Int
    
    init(power: Int, speed: Int) {
        self.power = power
        self.speed = speed
    }
    
    func makeJab() -> Bool {
     
        do {
            try throwJab()
        } catch BoxingError.NotEnoughPowerError {
            return false
        } catch BoxingError.NotEnoughSpeedError {
            return false
        } catch {
            return false
        }
        
        return true
    }
    
    private func throwJab() throws {
        
        if self.power < 70 {
            throw BoxingError.NotEnoughPowerError
        } else if self.speed < 100 {
            throw BoxingError.NotEnoughSpeedError
        } else {
            print("Throw -> JAB")
        }
    }
}

let boxer1 = Boxer(power: 70, speed: 90)
let result = boxer1.makeJab()
