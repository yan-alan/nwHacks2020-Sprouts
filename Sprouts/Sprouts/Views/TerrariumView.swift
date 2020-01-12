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
    lazy var gradientView = CAGradientLayer()
    lazy var notificationButton = UIButton()
    lazy var settingsButton = UIButton()
    lazy var cloud1View: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "cloud-1")
        
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var cloud2View: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "cloud-2")
        
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var cloud3View: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "cloud-3")
        
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var cloud4View: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "cloud-4")
        
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var cloud5View: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "cloud-2")
        
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsSelection = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false

        return collection
    }()
    override func setupView() {
        self.addSubview(cloud1View)
        self.addSubview(cloud2View)
        self.addSubview(cloud3View)
        self.addSubview(cloud4View)
        
        
        settingsButton.setSuperview(self).addTop(anchor: safeAreaLayoutGuide.topAnchor, constant: 4).addLeft(constant: 35).addWidth(withConstant: 36).addHeight(withConstant: 36).done()
        let imageView = ContentFitImageView().setSuperview(settingsButton).addConstraints(padding: 3)
        imageView.image = UIImage(named: "gear")
        notificationButton.setSuperview(self).addTop(anchor: safeAreaLayoutGuide.topAnchor, constant: 4).addRight(constant: -35).addWidth(withConstant: 36).addHeight(withConstant: 36).done()
        let imageView3 = ContentFitImageView().setSuperview(notificationButton).addConstraints(padding: 3)
        imageView3.image = UIImage(named: "notifications")
        gradientView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        gradientView.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.5, y: 1.0)
        let colour = UserDefaults.standard.integer(forKey: "colour1")

        if colour == 0 {
            gradientView.colors = [UIColor(hex: 0xCFD9FF).cgColor, UIColor(hex: 0x4569D2).cgColor]
        } else if colour == 1 {
            gradientView.colors = [UIColor(hex: 0xFFD258).cgColor, UIColor(hex: 0xFFB496).cgColor]
        } else {
            gradientView.colors = [UIColor(hex: 0xFFF2CE).cgColor, UIColor(hex: 0xFFD258).cgColor]
        }
    
        layer.insertSublayer(gradientView, at: 0)
        bottomView.setColor(.white)
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 25
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        ShadowUIView(radius: 2, subLayer: bottomView).setSuperview(self).addBottom().addRight().addLeft().addHeight(withConstant: 120).done()
        addButton.addCorners(33).setColor(.white)
        ShadowUIView(radius: 2, subLayer: addButton).setSuperview(self).addConstraints(bottom: safeAreaLayoutGuide.bottomAnchor, bottomConstant: -10
        , centerXAnchor: centerXAnchor, width: 66, height: 66).done()
        collectionView.setSuperview(self).addTop(anchor: settingsButton.bottomAnchor, constant: 15).addRight(constant: -35).addLeft(constant: 35).addBottom(anchor: bottomView.topAnchor, constant: -5).setColor(.clear)
        let image = UIImage(named: "plant-small")
        let imageView2 = ContentFitImageView().setSuperview(addButton).addConstraints(padding: 5)
        imageView2.image = image
        
        
        setupConstraintsWren()
    }
    
    func setupConstraintsWren() {
        //MARK: cloud1 Constraints
        cloud1View.widthAnchor.constraint(equalToConstant: 190).isActive = true
        cloud1View.heightAnchor.constraint(equalToConstant: 110).isActive = true
        cloud1View.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        cloud1View.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        
        //MARK: cloud3 Constraints
        cloud3View.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -100).isActive = true
        cloud3View.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 200).isActive = true
        
        //MARK: cloud4 Constraints
        cloud4View.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        cloud4View.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 150).isActive = true
        
        //MARK: cloud5 Constraints
        cloud4View.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        cloud4View.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -250).isActive = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


class TerrariumCollectionViewCell: UICollectionViewCell {
    lazy var plantImage = ContentFitImageView()
    lazy var waterImage = ContentFitImageView()

    var myWaterButtonDelegate: WaterButtonDelegate?
    lazy var waterButton: UIButton = {
        let button = UIButton()
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
                
        return button
    }()
    
    @objc func buttonPressed() {
        tellDelegateMyTag(self.waterButton.tag)
    }
    
    func tellDelegateMyTag(_ index: Int) {
        myWaterButtonDelegate?.pressedButtonAt(index)
    }
    lazy var dayLabel = UILabel()
    

    lazy var imageView = UIImageView()

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

        plantImage.setSuperview(self).addBottom().addRight().addLeft().addHeight(withConstant: 123).done()
        waterButton.setSuperview(self).addTop().addRight().addLeft().addBottom(anchor: plantImage.topAnchor).done()
        waterImage.setSuperview(waterButton).addConstraints().done()
        waterImage.image = UIImage(named: "waterdrop")
        
        plantImage.image = UIImage(named: "plant-default")
        imageView.setSuperview(self).addBottom(constant: -20).addWidth(withConstant: 30).addHeight(withConstant: 30).centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.image = UIImage(named: "selected")
        dayLabel.setSuperview(self).addTop().addRight().addLeft().addBottom(anchor: plantImage.topAnchor, constant: -10).done()
        dayLabel.textAlignment = .center
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
