var intValues = [1,2,3,4,5,6,7]
print(intValues)

intValues[0...2] = [1000,2000,3000,4000,5000]
print(intValues)

intValues = intValues.sorted()
intValues = intValues.sorted { (a, b) -> Bool in
    a < b
}
print(intValues)

for (index, intValue) in intValues.enumerated() {
    print("\(index) - \(intValue)")
}


var intValues2 = [1,2,3,4,5,6,7]
let sum = intValues2.reduce(0, { (x, a) in
    x + a
})
print(sum)

print(intValues2.filter({ (x) -> Bool in
    x > 5
}))

print(intValues2.map({ (x) -> String in
    String(x)+"XYZ"
}))

print(intValues2.map({ (x) -> Bool in
    x % 2 == 0
}))

let animalsPower = ["Lion": 100, "Leopard": 70, "Bear": 90, "Fox": 40]
print(animalsPower.reduce("") { (result, item) in
    result + "\(item.key) - \(item.value), "
})

print(animalsPower.filter({ (item) -> Bool in
    item.value > 70
}))

print(animalsPower.map({ (item) -> String in
    "\(item.key) - \(item.value)"
}))


let mySet: Set<Int> = [5,6,7,4,5,6]
print(mySet)
