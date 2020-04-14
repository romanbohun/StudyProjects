/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

  @IBOutlet weak var imagePreview: UIImageView!
  @IBOutlet weak var buttonClear: UIButton!
  @IBOutlet weak var buttonSave: UIButton!
  @IBOutlet weak var itemAdd: UIBarButtonItem!

  private let disposeBag = DisposeBag()
  private let images = BehaviorRelay<[UIImage]>(value: [])
  private var imageCache = [Int]()

  override func viewDidLoad() {
    super.viewDidLoad()

    images.subscribe(onNext: { [weak imagePreview] photos in
      guard let preview = imagePreview else { return }

      preview.image = photos.collage(size: preview.frame.size)
    }).disposed(by: disposeBag)

    images.subscribe(onNext: { [weak self] photos in
      self?.updateUI(with: photos)
    }).disposed(by: disposeBag)
  }

  @IBAction func actionClear() {
    images.accept([])
    imageCache = []
    navigationItem.leftBarButtonItem = UIBarButtonItem()
  }

  @IBAction func actionSave() {
    guard let image = imagePreview.image else { return }
    PhotoWriter.save(image)
      .subscribe(onSuccess: { [weak self] id in
        guard let self = self else { return }
        self.showMessage("Saved with id: \(id)")
        self.actionClear()
      }) { [weak self] error in
        self?.showMessage("Error", description: error.localizedDescription)
    }.disposed(by: disposeBag)
  }

  @available(iOS 13.0, *)
  @IBAction func actionAdd() {
    guard let photosViewController = storyboard?.instantiateViewController(identifier: "PhotosViewController") as? PhotosViewController else { return }
    navigationController?.pushViewController(photosViewController, animated: true)

    let newPhotos = photosViewController.selectedPhotos.share()
    newPhotos
      .takeWhile({ [weak self] image in
        let count = self?.images.value.count ?? 0
        return count < 6
      })
      .filter({ newImage in
        return newImage.size.width > newImage.size.height
      })
      .filter({ [weak self] newImage in
        let len = UIImagePNGRepresentation(newImage)?.count ?? 0
        guard self?.imageCache.contains(len) == false else {
          return false
        }
        self?.imageCache.append(len)
        return true
      })
      .subscribe(onNext: { [weak self] newImage in
        guard let self = self else { return }
        self.images.accept(self.images.value + [newImage])
        },
                 onDisposed: {
                  print("completed photot selection")
      }).disposed(by: disposeBag)

    newPhotos
    .ignoreElements()
      .subscribe(onCompleted: { [weak self] in
        self?.updateNavigationIcon()
      })
    .disposed(by: disposeBag)
  }

  func showMessage(_ title: String, description: String? = nil) {
    alert(title, description)
      .subscribe()
      .disposed(by: disposeBag)
  }

  private func updateUI(with photos: [UIImage]) {
    buttonSave.isEnabled = !photos.isEmpty && photos.count % 2 == 0
    buttonClear.isEnabled = !photos.isEmpty
    itemAdd.isEnabled = photos.count < 6
    title = !photos.isEmpty ? "\(photos.count) photos" : "Collage"
  }

  private func updateNavigationIcon() {
    let icon = imagePreview.image?
      .scaled(CGSize(width: 22 , height: 22 ))
      .withRenderingMode(.alwaysOriginal)
    navigationItem.leftBarButtonItem = UIBarButtonItem (image: icon, style: .done, target: nil , action: nil )
  }
}
