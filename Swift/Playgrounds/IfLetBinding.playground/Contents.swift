import UIKit

let personName: String? = "John"
var personJob: String? = "iOS developer"
var personAge: Int? = 25

if let unwrappedPersonName: String = personName {
    print(unwrappedPersonName)
} else {
    print("personName is nil")
}

if let unwrappedPersonalJob = personJob {
    print(unwrappedPersonalJob)
} else {
    print("personJob is nil")
}

if let unwrappedPersonAge = personAge {
    print(unwrappedPersonAge)
} else {
    print("personAge is nil")
}

if let unwrappedPersonAge: Int = personAge,
    let unwrappedPersonName: String = personName,
    let unwrappedPersonJob: String  = personJob {
    
    print("\(unwrappedPersonName), \(unwrappedPersonJob), \(unwrappedPersonAge)")
} else {
    print("nil for all")
}
