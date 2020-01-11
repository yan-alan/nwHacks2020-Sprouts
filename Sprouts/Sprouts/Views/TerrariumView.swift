//
//  TerrariumView.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit
import AlanYanHelpers

class TerrariumView: AYUIView {
    lazy var addButton = UIButton()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsSelection = true
        collection.translatesAutoresizingMaskIntoConstraints = false

        return collection
    }()
    override func setupView() {
        collectionView.setSuperview(self).addConstraints(padding: 0).setColor(.red)
        addButton.setSuperview(self).addBottom(constant: -10).addWidth(withConstant: 100).addHeight(withConstant: 200).addCorners(25).setColor(.blue)
        addButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}


class TerrariumCollectionViewCell: UICollectionViewCell {
    lazy var plantImage = ContentFitImageView()
    lazy var waterButton = UIButton()
    var model: Plant? {
        didSet{
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .red
        plantImage.setSuperview(self).addConstraints().done()
        waterButton.setSuperview(self).addTop(anchor: plantImage.bottomAnchor, constant: 0).addRight().addLeft().addBottom().addCorners(10).setColor(.blue)
        
        plantImage.image = UIImage(systemName: "leaf.arrow.circlepath")
    }
}
