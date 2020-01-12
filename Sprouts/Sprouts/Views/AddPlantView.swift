//
//  AddPlantView.swift
//  Sprouts
//
//  Created by Wren Liang on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit
import AlanYanHelpers

class AddPlantView: AYUIView {
    
    lazy var plantIcon = ContentFitImageView()

    lazy var searchButton = UIButton()

    lazy var dismissButton = UIButton()

    lazy var searchBar: UITextField = {
        let textField = UITextField()

        textField.placeholder = "search for plants to add..."
        textField.text = ""
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no

        textField.textAlignment = .left

        return textField
    }()

    lazy var tableView = UITableView()
    
    lazy var whiteView = UIView()
    lazy var wateringImage = ContentFitImageView()
    
    override func setupView(){
        backgroundColor = .clear
        whiteView.setSuperview(self).addBottom().addRight().addLeft().addTop(anchor: centerYAnchor, constant: -100).addCorners(30).setColor(.white)
        //MARK: plantIcon Constraints
        plantIcon.setSuperview(self).addBottom(anchor: whiteView.topAnchor, constant: 40).addHeight(withConstant: 150).addWidth(withConstant: 150).centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        plantIcon.image = UIImage(named: "plant-empty")
        let searchView = UIView()
        searchView.setSuperview(self).addLeft(constant: 30).addRight(constant: -30).addTop(anchor: plantIcon.bottomAnchor, constant: 10).addHeight(withConstant: 50).addCorners(25).done()
        searchView.layer.borderWidth = 1.5
        searchView.layer.borderColor = UIColor.black.cgColor
        
        searchButton.setSuperview(self).addTop(anchor: searchView.topAnchor).addRight(anchor: searchView.rightAnchor).addBottom(anchor: searchView.bottomAnchor).addWidth(withConstant: 50)
        let image = UIImageView()
        image.setSuperview(searchButton).addConstraints(padding: 10).done()
        image.image = UIImage(named:"magnifying-glass")
        let plantLabel = UILabel()
        plantLabel.setSuperview(self).addLeft(anchor: searchView.leftAnchor,constant: 20).addWidth(withConstant: 50).centerYAnchor.constraint(equalTo: searchView.topAnchor).isActive = true
        plantLabel.textAlignment = .center
        plantLabel.backgroundColor = .white
        plantLabel.text = "Plant"
        searchBar.setSuperview(self).addTop(anchor: searchView.topAnchor).addLeft(anchor: searchView.leftAnchor, constant: 20).addBottom(anchor: searchView.bottomAnchor).addRight(anchor: searchButton.leftAnchor).done()
        tableView.setSuperview(self).addBottom().addRight(constant: -60).addLeft(constant: 40).addTop(anchor: searchView.bottomAnchor, constant: 20).done()
        
        wateringImage.setSuperview(self).addLeft(constant: 20).addRight(constant: -20).addTop(anchor: searchView.bottomAnchor, constant: 20).addBottom(anchor: safeAreaLayoutGuide.bottomAnchor, constant: -20).isHidden = true
        }
}
