//
//  DetailedPlantView.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit
import AlanYanHelpers

class DetailedPlantView: AYUIView {
    lazy var plantIcon: UIImageView = {
        let image = UIImageView()
        
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.image = UIImage(named: "plant-default")
        
        return image
    }()
    
    lazy var plantLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Plant"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var scienceLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Scientific Label"
        label.font = UIFont.italicSystemFont(ofSize: 18)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    
    lazy var whiteBackground: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        view.addCorners(30).done()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var waterView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 173/255, green: 219/255, blue: 255/255, alpha: 0.66) /* #addbff */
        
        //view.addCorners(30)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var waterIcon: UIImageView = {
        let image = UIImageView()
        
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.image = UIImage(named: "waterdrop")
        
        return image
    }()
    
    lazy var waterTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Water"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var waterAmountLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Every 3 days"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var sunView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 255/255, green: 221/255, blue: 129/255, alpha: 0.66) /* #ffdd81 */
        
        //view.addCorners(30)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var sunIcon: UIImageView = {
        let image = UIImageView()
        
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0
        
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.image = UIImage(named: "sun")
        
        return image
    }()
    
    lazy var sunTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Sun"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var sunAmountLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Every 2 days"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var deleteButton = UIButton()
    
    var model: Plant? {
        didSet {
            //do work in the view once the plant is set
            plantLabel.text = model?.name
            scienceLabel.text = model?.scientificName
        }
    }
    
    override func setupView() {
        self.addSubview(whiteBackground)
        
        self.addSubview(plantLabel)
        self.addSubview(scienceLabel)
        self.addSubview(plantIcon)
        
        self.addSubview(waterView)
        self.addSubview(waterIcon)
        self.addSubview(waterTitleLabel)
        self.addSubview(waterAmountLabel)
        
        self.addSubview(sunView)
        self.addSubview(sunIcon)
        self.addSubview(sunTitleLabel)
        self.addSubview(sunAmountLabel)
        
        setupConstraints()
        
        deleteButton.setSuperview(self).addTop(anchor: whiteBackground.topAnchor, constant: 30).addLeft(constant: 0).addHeight(withConstant: 30).addHeight(withConstant: 30).done()
        let doneImage = ContentFitImageView()
        doneImage.setSuperview(deleteButton).addConstraints().done()
        doneImage.image = UIImage(named: "delete")
    }
    
    func setupConstraints() {
        //MARK: plantIcon Constraints
        plantIcon.bottomAnchor.constraint(equalTo: whiteBackground.topAnchor, constant: 40).isActive = true
        plantIcon.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        plantIcon.heightAnchor.constraint(equalToConstant: 150).isActive = true
        plantIcon.widthAnchor.constraint(equalToConstant: 170).isActive = true
        //MARK: plantLabel Constraints
        plantLabel.topAnchor.constraint(equalTo: plantIcon.bottomAnchor, constant: 5).isActive = true
        plantLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        plantLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 70).isActive = true
        plantLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -70).isActive = true
        
        //MARK: scienceLabel Constraints
        scienceLabel.topAnchor.constraint(equalTo: plantLabel.bottomAnchor, constant: 5).isActive = true
        scienceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        scienceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        scienceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        
        //MARK: Background Constraints
        whiteBackground.topAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
        whiteBackground.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        whiteBackground.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        whiteBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        //MARK: waterView Constraints
        waterView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        waterView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        waterView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -75).isActive = true
        waterView.topAnchor.constraint(equalTo: scienceLabel.bottomAnchor, constant: 50).isActive = true
        waterView.addCorners(100).done()
        
        //MARK: waterIcon Constraints
        waterIcon.centerXAnchor.constraint(equalTo: waterView.centerXAnchor, constant: 0).isActive = true
        waterIcon.bottomAnchor.constraint(equalTo: waterTitleLabel.topAnchor, constant: -15).isActive = true
        waterIcon.widthAnchor.constraint(equalToConstant: 70).isActive = true
        waterIcon.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        //MARK: waterTitleLabel Constraints
        waterTitleLabel.centerXAnchor.constraint(equalTo: waterView.centerXAnchor, constant: 0).isActive = true
        waterTitleLabel.centerYAnchor.constraint(equalTo: waterView.centerYAnchor, constant: 15).isActive = true

        //MARK: waterAmountLabel Constraints
        waterAmountLabel.centerXAnchor.constraint(equalTo: waterView.centerXAnchor, constant: 0).isActive = true
        waterAmountLabel.topAnchor.constraint(equalTo: waterTitleLabel.bottomAnchor, constant: 10).isActive = true
        
        
        //MARK: sunView Constraints
        sunView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        sunView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        sunView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 75).isActive = true
        sunView.topAnchor.constraint(equalTo: scienceLabel.bottomAnchor, constant: 50).isActive = true
        sunView.addCorners(100).done()
        
        //MARK: sunIcon Constraints
        sunIcon.centerXAnchor.constraint(equalTo: sunView.centerXAnchor, constant: 0).isActive = true
        sunIcon.bottomAnchor.constraint(equalTo: sunTitleLabel.topAnchor, constant: -15).isActive = true
        sunIcon.widthAnchor.constraint(equalToConstant: 70).isActive = true
        sunIcon.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        //MARK: sunTitleLabel Constraints
        sunTitleLabel.centerXAnchor.constraint(equalTo: sunView.centerXAnchor, constant: 0).isActive = true
        sunTitleLabel.centerYAnchor.constraint(equalTo: sunView.centerYAnchor, constant: 15).isActive = true

        //MARK: sunAmountLabel Constraints
        sunAmountLabel.centerXAnchor.constraint(equalTo: sunView.centerXAnchor, constant: 0).isActive = true
        sunAmountLabel.topAnchor.constraint(equalTo: sunTitleLabel.bottomAnchor, constant: 10).isActive = true
    }
}
