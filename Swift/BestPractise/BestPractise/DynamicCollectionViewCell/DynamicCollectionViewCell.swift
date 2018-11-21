//
//  DynamicCollectionViewCell.swift
//  BestPractise
//
//  Created by songgeb on 2018/11/21.
//  Copyright © 2018 Songgeb. All rights reserved.
//

import UIKit

class DynamicCollectionViewCell: UICollectionViewCell {
    private var titleHeightConstraint: NSLayoutConstraint!
    
    private lazy var myTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var yourTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .cyan
        
        contentView.addSubview(myTitleLabel)
        contentView.addSubview(yourTitleLabel)
        
        myTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: myTitleLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: myTitleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 8).isActive = true
        
        NSLayoutConstraint(item: myTitleLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -8).isActive = true
        
        NSLayoutConstraint(item: myTitleLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 134).isActive = true
        
        titleHeightConstraint = NSLayoutConstraint(item: myTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        titleHeightConstraint.priority = UILayoutPriority(985)
        titleHeightConstraint.isActive = true
        
        yourTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: yourTitleLabel, attribute: .top, relatedBy: .equal, toItem: myTitleLabel, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: yourTitleLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 8).isActive = true
        
        NSLayoutConstraint(item: yourTitleLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -8).isActive = true
        
        NSLayoutConstraint(item: yourTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 10).isActive = true
        
        NSLayoutConstraint(item: yourTitleLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }
    
    func reset(title: String, index: Int) {
        yourTitleLabel.text = "your title"
        myTitleLabel.text = index % 2 == 0 ? title : (0..<2).reduce("", { (result, _) in
            result + title
        })
        titleHeightConstraint.constant = index % 2 == 0 ? 150 : 30
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        print(attributes.frame)
        return attributes
    }
}
