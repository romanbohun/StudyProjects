//
//  ViewController.swift
//  CameraFilter
//
//  Created by Roman Bogun on 23.03.2020.
//  Copyright © 2020 Roman Bohun. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var filterButton: UIButton!

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Camera filter"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        filterButton.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController,
            let photosCollectionViewController = navigationController.viewControllers.first as? PhotocCollectionViewController else {
                fatalError("Segue destination is not found")
        }
        
        photosCollectionViewController.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
    }
    
    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.filterButton.isHidden = false
    }
    
    @objc private func applyFilter(target: UIButton) {
        guard let unwrappedImage = photoImageView.image else { return }
        let filterServie = FilterService()
        filterServie.applyFilter(to: unwrappedImage)
            .subscribe(onNext: { [weak self] filteredImage in
                DispatchQueue.main.async {
                    self?.photoImageView.image = filteredImage
                }
            }).disposed(by: disposeBag)
    }
    
}

