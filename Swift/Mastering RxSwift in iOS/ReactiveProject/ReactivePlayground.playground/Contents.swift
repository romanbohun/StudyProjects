import UIKit
import RxSwift
import RxCocoa
import PlaygroundSupport

let disposeBag = DisposeBag()

// MARK: - OBSERVABLES

//let obs1 = Observable.just(1)
//let obs2 = Observable.of(1,2,3,4,5)
//let obs3 = Observable.of([1,2,3,4,5])
//let obs4 = Observable.from([6,7,8,9,10])
//obs1.subscribe { event in
//    print(event)
//}
//
//obs2.subscribe { event in
//    if let element = event.element {
//        print(element)
//    }
//}
//let disposeBag = DisposeBag()
//
//let subscription4 = obs4.subscribe { event in
//    if let element = event.element {
//        print(element)
//    }
//}
//subscription4.dispose()
//
//obs4.subscribe(onNext: { element in
//    print(element)
//}).disposed(by: disposeBag)
//
//Observable<String>.create { observer in
//    observer.onNext("A")
//    observer.onNext("B")
//    observer.onNext("C")
//    observer.onCompleted()
//    observer.onNext("?")
//    return Disposables.create()
//}.subscribe(onNext: { print($0) }, onError: { print($0) }, onCompleted: {
//    print("Complited")
//}, onDisposed: { print("Disposed") })
//.disposed(by: disposeBag)

//MARK: - SUBJECTS

//------------------
// Publish Subjects
//------------------
//let subject = PublishSubject<String>();
//subject.onNext("Issue 1")
//subject.subscribe { event in
//    print(event)
//}
//subject.onNext("Issue 2")
//subject.onNext("Issue 3")
//
////subject.dispose()
//subject.onCompleted()
//subject.onNext("Issue 4")

//------------------
// Behavior Subjects
//------------------
//let behSubject = BehaviorSubject(value: "Initial value")
//behSubject.onNext("Last Issue")
//behSubject.onNext("Last Issue2")
//behSubject.onNext("Last Issue3")
//behSubject.subscribe { event in
//    print(event)
//}
//behSubject.onNext("Issue 1")

//------------------
// Replay Subjects
//------------------
//let replSubject = ReplaySubject<String>.create(bufferSize: 2)
//replSubject.onNext("Issue 1")
//replSubject.onNext("Issue 2")
//replSubject.onNext("Issue 3")
//
//replSubject.subscribe { event in
//    print("1---\(event)")
//}
//replSubject.onNext("Issue 4")
//replSubject.onNext("Issue 5")
//replSubject.onNext("Issue 6")
//print("----------")
//replSubject.subscribe {
//    print("2---\($0)")
//}

//------------------
// Variables Subjects
//------------------
//let variable = Variable("Initial value")
//variable.value = "Hello world"
//variable.value = "Hello world2"
//variable.asObservable()
//    .subscribe { print($0) }
//variable.value = "Hello world3"
//variable.value = "Hello world4"

//let variable2 = Variable([String]())
//variable2.value.append("Item 1")
//variable2.value.append("Item 2")
//variable2.asObservable()
//    .subscribe { print($0) }
//variable2.value.append("Item 3")
//variable2.value.append("Item 4")

//------------------
// BehaviorRelay Subjects
//------------------
//let relay = BehaviorRelay<String>(value: "Initial value")
//relay.asObservable()
//    .subscribe {
//        print($0)
//}
//relay.accept("Hello World")

//let relay = BehaviorRelay(value: ["Item 1"])
//
////relay.accept(["Item 2"])
////relay.accept(relay.value + ["Item 2"])
//
//var value = relay.value
//value.append("Item 2")
//value.append("Item 3")
//relay.accept(value)
//
//relay.asObservable()
//    .subscribe {
//        print($0)
//}


// MARK: - FILTERING OPERATORS

//------------------
// Ignore
//------------------

//let strikes = PublishSubject<String>()
//strikes
//.ignoreElements()
//    .subscribe { _ in
//        print("Subscription is Called!")
//}
//.disposed(by: disposeBag)
//
//strikes.onNext("Item 1")
//strikes.onNext("Item 2")
//strikes.onNext("Item 3")
//
//strikes.onCompleted()

//------------------
// ElementAt
//------------------
//let strikes = PublishSubject<String>()
//strikes.elementAt(2)
//    .subscribe { event in
//        print(event)
//
//        print("You are out!")
//}.disposed(by: disposeBag)
//
//strikes.onNext("Item 1")
//strikes.onNext("Item 2")
//strikes.onNext("Item 3")
//strikes.onNext("Item 4")

//------------------
// Filter
//------------------
//Observable.of(1,2,3,4,5,6,7)
//    .filter { value in
//        value % 2 == 0
//}.subscribe(onNext: { value in
//    print(value)
//    }).disposed(by: disposeBag)

//------------------
// Skip
//------------------
//Observable.of("A", "B", "C", "D", "E", "F")
//    .skip(3)
//    .subscribe(onNext: { value in
//        print(value)
//    }).disposed(by: disposeBag)

//------------------
// Skip While
//------------------

//Observable.of("A", "B", "C", "D", "E", "F")
//    .skipWhile({ value in
//        value != "E"
//    })
//    .subscribe(onNext: { value in
//        print(value)
//    }).disposed(by: disposeBag)
//
//Observable.of(2,2,3,4,4)
//    .skipWhile { value in
//        value % 2 == 0
//}.subscribe(onNext: { value in
//    print(value)
//    }).disposed(by: disposeBag)

//------------------
// Skip Until
//------------------

//let subject = PublishSubject<String>()
//let trigger = PublishSubject<String>()
//
//subject.skipUntil(trigger)
//    .subscribe(onNext: { value in
//        print(value)
//    }).disposed(by: disposeBag)
//
//subject.onNext("A")
//subject.onNext("B")
//
//trigger.onNext("X")
//
//subject.onNext("C")
//subject.onNext("D")

//------------------
// Take
//------------------

//Observable.of(1,2,3,4,5,6)
//    .take(3)
//    .subscribe(onNext: { value in
//        print(value)
//    }).disposed(by: disposeBag)


//let nums = PublishSubject<Int>()
//nums.asObservable()
//.take(3)
//.subscribe(onNext: { value in
//    print(value)
//}).disposed(by: disposeBag)
//nums.onNext(1)
//nums.onNext(2)
//nums.onNext(3)
//nums.onNext(4)

//------------------
// Take While
//------------------
//Observable.of(2,4,6,7,8)
//    .takeWhile { value in
//        value % 2 == 0
//}.subscribe(onNext: { value in
//    print(value)
//}).disposed(by: disposeBag)

//let nums = PublishSubject<Int>()
//nums.asObservable()
//    .takeWhile { value in
//        value % 2 == 0
//}.subscribe(onNext: { value in
//    print(value)
//}).disposed(by: disposeBag)
//nums.onNext(2)
//nums.onNext(2)
//nums.onNext(4)
//nums.onNext(6)
//nums.onNext(7)
//nums.onNext(8)

//------------------
// Take Until
//------------------
//let subject = PublishSubject<String>()
//let trigger = PublishSubject<String>()
//
//subject.takeUntil(trigger)
//    .subscribe(onNext: { value in
//        print(value)
//    }).disposed(by: disposeBag)
//
//subject.onNext("A")
//subject.onNext("B")
//
//trigger.onNext("X")
//
//subject.onNext("C")
//subject.onNext("D")

protocol Pet: class  {
    var name: String { get }
}

class Cat: Pet {
    var name: String
    
    init (name: String ) {
        self.name = name
    }
}
class Dog: Pet {
    var name: String
    
    init (name: String ) {
        self.name = name
    }
}


class Keeper<Animal: Pet> {
    var name: String
    var morningCare: Animal
    var afternoonCare: Animal
    
    init (name: String , morningCare: Animal, afternoonCare: Animal ) {
        self.name = name
        self.morningCare = morningCare
        self.afternoonCare = afternoonCare
    }
}


let jason = Keeper (name: "Jason" , morningCare: Cat (name: "Whiskers" ), afternoonCare: Cat (name: "Sleepy" ))

extension Array where Element: Cat {
    func meow() {
        
    }
}

let array = [Cat]()
array.meow()


