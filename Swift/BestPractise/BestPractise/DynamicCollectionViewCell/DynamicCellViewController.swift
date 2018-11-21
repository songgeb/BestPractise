//
//  DynamicCellViewController.swift
//  BestPractise
//
//  Created by songgeb on 2018/11/21.
//  Copyright © 2018 Songgeb. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

class DynamicCellViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    //collectionview is not ready before loadView, such as awakeFromNib(), so apple document of awakeFromNib() is wrong
    override func loadView() {
        super.loadView()
        //must not use cell in storyboard, or you will encounter constraint warning
        collectionView.register(DynamicCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.estimatedItemSize = CGSize(width: 150, height:11)
    }
}

extension DynamicCellViewController: UICollectionViewDataSource {
    
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
