import Foundation
import RxSwift
import RxCocoa

example(of: "PublishSubject") {
  
  let disposeBag = DisposeBag()
  
  let dealtHand = PublishSubject<[(String, Int)]>()
  
  func deal(_ cardCount: UInt) {
    var deck = cards
    var cardsRemaining = deck.count
    var hand = [(String, Int)]()
    
    for _ in 0..<cardCount {
      let randomIndex = Int.random(in: 0..<cardsRemaining)
      hand.append(deck[randomIndex])
      deck.remove(at: randomIndex)
      cardsRemaining -= 1
    }
    
    // Add code to update dealtHand here
    let calculatedPoints = points(for: hand)
    if calculatedPoints > 21 {
        dealtHand.onError(HandError.busted(points: calculatedPoints))
    } else {
        dealtHand.onNext(hand)
    }
  }
  
  // Add subscription to dealtHand here
    dealtHand.subscribe(onNext: { element in
        print(cardString(for: element))
    }, onError: { error in
        print("Error")
    }).disposed(by: disposeBag)
  
  deal(3)
}
