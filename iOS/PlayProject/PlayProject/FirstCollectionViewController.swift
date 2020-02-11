//
//  FirstCollectionViewController.swift
//  PlayProject
//
//  Created by Roman Bogun on 7/24/19.
//  Copyright © 2019 Roman Bohun. All rights reserved.
//

import UIKit

private let reuseIdentifier = "TitleCollectionViewCell"

class FirstCollectionViewController: UICollectionViewController {

    // 1
    weak var delegate: MyLayoutDelegate!
    
    // 2
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 6
    
    // 3
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    
    // 4
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
//    // 5
//    override var collectionViewContentSize: CGSize {
//        return CGSize(width: contentWidth, height: contentHeight)
//    }
    
    private var data: Array<String> = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataInit()
        
//        self.collectionView!.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TitleCollectionViewCell
        
        cell.backgroundColor = .red
        cell.title?.text = self.data[indexPath.row]
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    private func dataInit() {
        
        for i in 0...9 {
            self.data.append("Cell \(i)")
        }
    }
}


extension FirstCollectionViewController: UICollectionViewDelegateFlowLayout {
}

protocol MyLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat
}
