import Foundation

class SingletonTester
{
  static func isSingleton(factory: () -> AnyObject) -> Bool
  {
    let obj1 = factory()
    let obj2 = factory()
    print(obj1)
    print(obj2)
    return obj1 === obj2

    }
}

class A {
    var t: Int = 0

    static let instance = A()
    private init() {
        t = t + 1
    }
}

let closure: () -> AnyObject = {
    print("=======---->" + String(A.instance.t))
    return A.instance as AnyObject
}

SingletonTester.isSingleton{ closure() }
