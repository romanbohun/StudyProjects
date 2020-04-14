import Foundation
import RxSwift

//example(of: "subscribe") {
//    let observable = Observable.of(1, 2, 3)
//    observable.subscribe(onNext: { element in
//        print(element)
//    })
//}
//
//example(of: "empty") {
//    let observable = Observable<Void>.empty()
//    observable.subscribe(onNext: { element in
//        print(element)
//    }, onCompleted: {
//        print("Completes")
//    })
//}
//
//example(of: "never") {
//    let observable = Observable<Any>.never()
//    observable.subscribe(onNext: { element in
//        print(element)
//    }, onCompleted: {
//        print("Completes")
//    })
//}
//
//example(of: "dispose") {
//    let observable = Observable.of("A", "B", "C")
//    let subscription = observable.subscribe { event in
//        print(event)
//    }
//    subscription.dispose()
//}
//
//example(of: "disposeBag") {
//    let disposeBag = DisposeBag()
//    Observable.of("A", "B", "C")
//        .subscribe { event in
//            print(event)
//        }
//    .disposed(by: disposeBag)
//}
//
//example(of: "create") {
//    let disposeBag = DisposeBag()
//
//    enum MyError: Error {
//        case anError
//    }
//
//    Observable<String>.create { observer in
//        observer.onNext("1")
////        observer.onError(MyError.anError)
//        observer.onCompleted()
//        observer.onNext("?")
//        return Disposables.create()
//    }.subscribe(
//        onNext: { print ( $0 ) },
//        onError: { print ( $0 ) },
//        onCompleted: { print ( "Completed" ) },
//        onDisposed: { print ( "Disposed" ) }
//    ).disposed(by: disposeBag)
//}
//
//example(of: "deferred") {
//    let disposeBag = DisposeBag()
//    // 1
//    var flip = false
//    // 2
//    let factory: Observable < Int > = Observable .deferred {
//        // 3
//        flip.toggle()
//        // 4
//        if flip {
//            return Observable.of( 1 , 2 , 3 )
//        } else {
//            return Observable.of( 4 , 5 , 6 )
//        }
//    }
//
//    for _ in 0...3 {
//        factory.subscribe(onNext: {
//            print ($0 , terminator: "" )
//        }).disposed(by: disposeBag)
//        print ()
//    }
//}
//
//example(of: "Single" ) {
//    // 1
//    let disposeBag = DisposeBag ()
//    // 2
//    enum FileReadError : Error {
//        case fileNotFound, unreadable, encodingFailed
//    }
//    // 3
//    func loadText(from name: String) -> Single<String> {
//        // 4
//        return Single.create { single in
//            // 1
//            let disposable = Disposables.create()
//
//            // 2
//            guard let path = Bundle.main.path(forResource: name, ofType: "txt" ) else {
//                single(.error(FileReadError.fileNotFound))
//                return disposable
//            }
//
//            // 3
//            guard let data = FileManager.default.contents(atPath: path) else {
//                single(.error(FileReadError.unreadable))
//                return disposable
//            }
//
//            // 4
//            guard let contents = String(data: data, encoding: .utf8) else {
//                single(.error(FileReadError.encodingFailed))
//                return disposable
//            }
//
//            // 5
//            single(.success(contents))
//            return disposable
//        }
//    }
//
//    // 1
//    loadText(from: "Copyright")
//        // 2
//        .subscribe {
//            // 3
//            switch $0 {
//            case .success( let string):
//                print (string)
//            case .error( let error):
//                print (error)
//            }
//    }.disposed(by: disposeBag)
//}
//
//example(of: "never") {
//    let observable = Observable<Any>.never()
////
////    observable.subscribe(onNext: { element in
////        print(element)
////    }, onCompleted: {
////        print("Completes")
////    })
//  let disposeBag = DisposeBag()
//
//  observable
//    .do(onNext: { event in
//        print(event)
//    }, onError: { error in
//        print(error)
//    }, onCompleted: {
//        print("OnCompleted")
//    }, onSubscribe: {
//        print("OnSubscribe")
//    }, onSubscribed: {
//        print("OnSubscribeb")
//    }, onDispose: {
//        print("OnDispose")
//    })
//    .subscribe(
//      onNext: { element in
//        print(element)
//      },
//      onCompleted: {
//        print("Completed")
//      },
//      onDisposed: {
//        print("Disposed")
//      }
//    )
//    .disposed(by: disposeBag)
//}
//
//example(of: "never2") {
//  let observable = Observable<Any>.never()
//  let disposeBag = DisposeBag()
//
//  observable
//    .debug("observable")
//    .subscribe(
//      onNext: { element in
//        print(element)
//      },
//      onCompleted: {
//        print("Completed")
//      },
//      onDisposed: {
//        print("Disposed")
//      }
//    )
//    .disposed(by: disposeBag)
//}
