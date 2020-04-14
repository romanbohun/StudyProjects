//
//  UIViewController+rx.swift
//  Combinestagram
//
//  Created by Roman Bogun on 13.04.2020.
//  Copyright © 2020 Underplot ltd. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension UIViewController {

  func alert(_ title: String?, _ details: String?) -> Completable {
    return Completable.create(subscribe: { [weak self] observer in
      let alert = UIAlertController(title: title, message: details, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { _ in
        observer(.completed)
      }))
      self?.present(alert, animated: true, completion: nil)
      return Disposables.create { [weak self] in
        self?.dismiss(animated: true, completion: nil)
      }
    })
  }
}
