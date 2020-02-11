//
//  ViewController.swift
//  CollectionView
//
//  Created by Roman Bohun on 12.07.2019.
//  Copyright © 2019 Roman Bohun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    enum Section {
        case main
        case other
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(TextCell.self, forCellWithReuseIdentifier: TextCell.reuseIdentifier)
//        collectionView.delegate = self
        
        configureDataSource()
    }
}

extension ViewController {
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        group.interItemSpacing = .flexible(CGFloat(10))
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension ViewController {
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            
            // Get a cell of the desired kind.
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TextCell.reuseIdentifier,
                for: indexPath) as? TextCell else { fatalError("Cannot create new cell") }
            
            // Populate the cell with our item description.
            cell.label.text = "\(identifier)"
            
            cell.contentView.backgroundColor = .blue
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
            
            // Return the cell.
            return cell
        }
        
        let snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main, .other])
//        snapshot.appendItems(Array(0..<24))
        snapshot.appendItems(Array(0..<24), toSection: .main)
        snapshot.appendItems(Array(30..<41), toSection: .other)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
