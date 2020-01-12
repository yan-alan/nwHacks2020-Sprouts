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
    lazy var topView = UIView()
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
        topView.setColor(.white)
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 25
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        bottomView.setColor(.white)
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 25
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        ShadowUIView(subLayer: bottomView).setSuperview(self).addBottom().addRight().addLeft().addHeight(withConstant: 100).done()
        ShadowUIView(subLayer: topView).setSuperview(self).addTop().addRight().addLeft().addHeight(withConstant: 100).done()
        collectionView.setSuperview(self).addTop(anchor: topView.bottomAnchor, constant: 10).addRight().addLeft().addBottom(anchor: bottomView.topAnchor, constant: -10).setColor(.white)
        addButton.setSuperview(self).addBottom(anchor: safeAreaLayoutGuide.bottomAnchor,constant: -10).addWidth(withConstant: 50).addHeight(withConstant: 50).addCorners(25).setColor(.blue)
        addButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
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
