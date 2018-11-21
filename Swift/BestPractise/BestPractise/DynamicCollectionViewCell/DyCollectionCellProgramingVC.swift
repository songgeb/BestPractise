//
//  DynamicCellViewController.swift
//  BestPractise
//
//  Created by songgeb on 2018/11/21.
//  Copyright © 2018 Songgeb. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

class DyCollectionCellProgramingVC: UIViewController {
    
    private var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        automaticallyAdjustsScrollViewInsets = false
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 150, height:11)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(DynamicCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self.bottomLayoutGuide, attribute: .top, multiplier: 1, constant: 0).isActive = true
    }
}

extension DyCollectionCellProgramingVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DynamicCollectionViewCell
        cell.reset(title: "我勒个去", index: indexPath.item)
        return cell
    }
}
