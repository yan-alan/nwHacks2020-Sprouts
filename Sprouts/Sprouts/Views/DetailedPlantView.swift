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
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.backgroundColor = .purple
        image.image = UIImage(named: "test-plant-pot")
        
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
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    
    lazy var whiteBackground: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        view.addCorners(30)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    var model: Plant? {
        didSet {
            //do work in the view once the plant is set
        }
    }
    
    override func setupView() {
        self.addSubview(whiteBackground)
        
        self.addSubview(plantLabel)
        self.addSubview(scienceLabel)
        self.addSubview(plantIcon)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        //MARK: plantLabel Constraints
        plantLabel.topAnchor.constraint(equalTo: plantIcon.bottomAnchor, constant: 25).isActive = true
        plantLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        plantLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        plantLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        
        //MARK: scienceLabel Constraints
        scienceLabel.topAnchor.constraint(equalTo: plantLabel.bottomAnchor, constant: 25).isActive = true
        scienceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        scienceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        scienceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        
        //MARK: plantIcon Constraints
        plantIcon.bottomAnchor.constraint(equalTo: whiteBackground.topAnchor, constant: 50).isActive = true
        plantIcon.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        plantIcon.heightAnchor.constraint(equalToConstant: 300).isActive = true
        plantIcon.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        //MARK: Background Constraints
        whiteBackground.topAnchor.constraint(equalTo: centerYAnchor, constant: -100).isActive = true
        whiteBackground.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        whiteBackground.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        whiteBackground.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
}
