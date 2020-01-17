//
//  SettingsView.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-12.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit
import AlanYanHelpers

class SettingsView: AYUIView {
    lazy var whiteView = UIView()
    lazy var colourOptionOne = UIButton()
    lazy var colourOptionTwo = UIButton()
    lazy var colourOptionThree = UIButton()
    lazy var overlayOne = UIView()
    lazy var overlayTwo = UIView()
    lazy var overlayThree = UIView()

    override func setupView() {
        whiteView.setSuperview(self).addBottom().addRight().addLeft().addHeight(withConstant: 240).addCorners(30).setColor(.white).done()
               //MARK: plantIcon Constraints
        let settingsLabel = UILabel()
        settingsLabel.setSuperview(self).addTop(anchor: whiteView.topAnchor, constant: 20).centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        settingsLabel.text = "Settings"
        settingsLabel.textAlignment = .center
        settingsLabel.setFont(name: "Futura-Bold", size: 30).done()
        
        let colourLabel = UILabel()
        colourLabel.setSuperview(self).addTop(anchor: settingsLabel.bottomAnchor, constant: 10).addLeft(constant: 20).addRight(constant: -20).done()
        colourLabel.text = "Colour Scheme:"
        colourLabel.textAlignment = .left
        colourLabel.setFont(name: "Futura", size: 17).done()
        
        colourOptionOne.tag = 1

        colourOptionOne.setSuperview(self).addTop(anchor: colourLabel.bottomAnchor, constant: 20).addWidth(withConstant: 50).addHeight(withConstant: 50).addCorners(25).centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        colourOptionOne.addSubview(overlayOne)
//        overlayOne.addConstraints()
        var gradientView = CAGradientLayer()
        gradientView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        gradientView.startPoint = CGPoint(x: 0.3, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.7, y: 1.0)
        gradientView.colors = [UIColor(hex: 0xCFD9FF).cgColor, UIColor(hex: 0x4569D2).cgColor]
        colourOptionOne.layer.insertSublayer(gradientView, at: 0)

        colourOptionTwo.tag = 2
        colourOptionTwo.setSuperview(self).addTop(anchor: colourLabel.bottomAnchor, constant: 20).addWidth(withConstant: 50).addHeight(withConstant: 50).addCorners(25).addLeft(anchor: colourOptionOne.rightAnchor, constant: 10).done()
//        overlayTwo.setSuperview(colourOptionTwo).addConstraints().done()
        colourOptionTwo.setImage(UIImage(systemName: "checkmark"), for: .normal)

        gradientView = CAGradientLayer()
        gradientView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        gradientView.startPoint = CGPoint(x: 0.3, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.7, y: 1.0)
        gradientView.colors = [UIColor(hex: 0xFFD258).cgColor, UIColor(hex: 0xFFB496).cgColor]
        colourOptionTwo.layer.insertSublayer(gradientView, at: 0)
        
        colourOptionThree.tag = 3
        colourOptionThree.setSuperview(self).addTop(anchor: colourLabel.bottomAnchor, constant: 20).addWidth(withConstant: 50).addHeight(withConstant: 50).addCorners(25).addRight(anchor: colourOptionOne.leftAnchor, constant: -10).done()
//        overlayThree.setSuperview(colourOptionThree).addConstraints().done()
        gradientView = CAGradientLayer()
        gradientView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        gradientView.startPoint = CGPoint(x: 0.3, y: 0.0)
        gradientView.endPoint = CGPoint(x: 0.7, y: 1.0)
        gradientView.colors = [UIColor(hex: 0xFFF2CE).cgColor, UIColor(hex: 0xFFD258).cgColor]
        colourOptionThree.layer.insertSublayer(gradientView, at: 0)
        
    }
}
