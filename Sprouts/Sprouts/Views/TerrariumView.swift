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
    lazy var bottomView = UIView()
    lazy var addButton = UIButton()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsSelection = true
        collection.translatesAutoresizingMaskIntoConstraints = false

        return collection
    }()
    override func setupView() {
        backgroundColor = .white
        bottomView.setColor(.white)
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 25
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        ShadowUIView(radius: 2, subLayer: bottomView).setSuperview(self).addBottom().addRight().addLeft().addHeight(withConstant: 120).done()
        addButton.addCorners(33).setColor(.white)
        ShadowUIView(radius: 2, subLayer: addButton).setSuperview(self).addConstraints(bottom: safeAreaLayoutGuide.bottomAnchor, bottomConstant: -10
        , centerXAnchor: centerXAnchor, width: 66, height: 66).done()
        let image = UIImage(named: "plant-small")
        let imageView = ContentFitImageView().setSuperview(addButton).addConstraints(padding: 5)
        imageView.image = image
    }
    override func layoutSubviews() {
        super.layoutSubviews()
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

        plantImage.setSuperview(self).addConstraints().done()
        waterButton.setSuperview(self).addTop(anchor: plantImage.bottomAnchor, constant: 0).addRight().addLeft().addBottom().addCorners(10).setColor(.blue)
        
        plantImage.image = UIImage(systemName: "leaf.arrow.circlepath")
    }
}


extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
