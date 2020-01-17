//
//  SetTimeToWaterView.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-12.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit
import AlanYanHelpers

class SetTimeToWaterView: AYUIView {
    
    lazy var plantIcon = ContentFitImageView()


    lazy var dismissButton = UIButton()

    lazy var whiteView = UIView()
    var model: Plant? {
        didSet{
            plantIcon.image = UIImage(named: model!.pictureName)
        }
    }
    lazy var searchBar: UITextField = {
        let textField = UITextField()

        textField.placeholder = "watering frequency? (s)"
        textField.text = ""
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .asciiCapableNumberPad
        textField.textAlignment = .left

        return textField
    }()
    lazy var addButton = UIButton()
    override func setupView(){
        backgroundColor = .clear
        whiteView.setSuperview(self).addBottom().addRight().addLeft().addTop(anchor: centerYAnchor, constant: -100).addCorners(30).setColor(.white).done()
        
        //MARK: plantIcon Constraints
        plantIcon.setSuperview(self).addBottom(anchor: whiteView.topAnchor, constant: 40).addHeight(withConstant: 200).addWidth(withConstant: 150).centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        let searchView = UIView()
        searchView.setSuperview(self).addLeft(constant: 30).addRight(constant: -30).addTop(anchor: plantIcon.bottomAnchor, constant: 10).addHeight(withConstant: 50).addCorners(25).done()
        searchView.layer.borderWidth = 1.5
        searchView.layer.borderColor = UIColor.black.cgColor
        
        let plantLabel = UILabel()
        plantLabel.setSuperview(self).addLeft(anchor: searchView.leftAnchor,constant: 20).addWidth(withConstant: 170).centerYAnchor.constraint(equalTo: searchView.topAnchor).isActive = true
        plantLabel.textAlignment = .center
        plantLabel.backgroundColor = .white
        plantLabel.text = "Watering Frequency"
        searchBar.setSuperview(self).addTop(anchor: searchView.topAnchor).addLeft(anchor: searchView.leftAnchor, constant: 20).addBottom(anchor: searchView.bottomAnchor).addRight(anchor: searchView.rightAnchor, constant: -20).done()
        
        addButton.setSuperview(self).addTop(anchor: searchView.bottomAnchor, constant: 10).addHeight(withConstant: 0).addWidth(withConstant: 100).addCorners(10).setColor(.clear).done()
        addButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        let label = UILabel()
        label.setSuperview(addButton).addConstraints(padding: 5).done()
        label.textAlignment = .center
        label.text = "Add"
        label.setFont(name: "Futura", size: 20).done()
        label.textColor = UIColor(hex: 0x587FFF)
        
        }
}
