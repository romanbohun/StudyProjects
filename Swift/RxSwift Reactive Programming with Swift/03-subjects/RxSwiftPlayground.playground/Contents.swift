import Foundation
import RxSwift
import RxCocoa

enum MyError: Error {
    case anError
}

func print <T: CustomStringConvertible> (_ label: String, _ event: Event<T>) {
    print (label, (event.element ?? event.error) ?? event)
}

//example(of: "PublishSubject" ) {
//    let subject = PublishSubject<String>()
//    subject.onNext("Is anyone listening?")
//
//    let subscriptionOne = subject
//        .subscribe { event in
//            print(event.element ?? event)
//    }
//
//    subject.on(.next("1"))
//    subject.onNext("2")
//
//    let subscriptionTwo = subject
//        .subscribe { event in
//            print("2) ", event.element ?? event)
//    }
//    subject.onNext("3")
//
//    subscriptionOne.dispose()
//    subject.onNext("4")
//
//    subject.onCompleted()
//    subject.onNext("5")
//    subscriptionTwo.dispose()
//    let disposedBag = DisposeBag()
//
//    subject
//        .subscribe { event in
//            print("3)", event.element ?? event)
//    }.disposed(by: disposedBag)
//
//    subject.onNext("?")
//}
//
//
//
//
//example(of: "BehaviorSubject" ) {
//    let subject = BehaviorSubject<String>(value: "Initial value")
//    let disposeBag = DisposeBag()
//
//    subject.onNext("X")
//    subject
//        .subscribe { element in
//            print("1)", element)
//    }
//    .disposed(by: disposeBag)
//
//    subject.onError(MyError.anError)
//
//    subject
//        .subscribe { element in
//            print("2)", element)
//    }
//.disposed(by: disposeBag)
//}
//
//
//
//
//example(of: "ReplaySubject" ) {
//    let subject = ReplaySubject<String>.create(bufferSize: 2)
//    let disposeBag = DisposeBag()
//
//    subject.onNext("1")
//    subject.onNext("2")
//    subject.onNext("3")
//
//    subject
//        .subscribe { element in
//            print("1)", element)
//    }
//    .disposed(by: disposeBag)
//
//    subject
//        .subscribe { element in
//            print("2)", element)
//    }
//    .disposed(by: disposeBag)
//
//    subject.onNext("4")
//    subject.onError(MyError.anError)
//    subject.dispose()
//
//    subject
//        .subscribe { element in
//            print("3)", element)
//    }
//    .disposed(by: disposeBag)
//
//}
//
//
//
//
//example(of: "AsyncSubject" ) {
//    let subject = AsyncSubject<String>()
//    subject.onNext("Is anyone listening?")
//    subject.on(.next("0"))
//    let subscriptionOne = subject
//        .subscribe(onNext: { element in
//            print(element)
//        })
//
//    subject.onCompleted()
//}
//
//
//
//
//example(of: "PublishRelay" ) {
//    let relay = PublishRelay<String>()
//    let disposeBag = DisposeBag()
//    relay.accept("Knock knock, anyone home?")
//    relay.accept("0")
//
//    relay
//        .subscribe(onNext: { element in
//            print(element)
//        })
//        .disposed(by: disposeBag)
//
//    relay.accept("1")
//}
//
//
//
//

example(of: "BehaviorRelay" ) {
    let relay = BehaviorRelay<String>(value: "Initial value")
    let disposeBag = DisposeBag()
    relay.accept("New initial value")
    relay
        .subscribe { event in
            print("1)", event)
    }
    .disposed(by: disposeBag)

    relay.accept("1")

    relay
        .subscribe { event in
            print("2)", event)
    }
    .disposed(by: disposeBag)

    relay.accept("2")
}
