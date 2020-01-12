//
//  LoginView.swift
//  Sprouts
//
//  Created by Wren Liang on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit
import AlanYanHelpers
class LoginView: UIView {
    
    lazy var gradientView = CAGradientLayer()
    
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
    
    lazy var emailBar: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Username"
        textField.text = ""
        textField.autocapitalizationType = .none
        textField.textAlignment = .center
        textField.backgroundColor = .white
        
        return textField
    }()
    
    lazy var passwordBar: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.text = ""
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.backgroundColor = .white
        
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
//        button.backgroundColor = UIColor(hex: 0x302F82)
        button.setTitleColor(UIColor.white, for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        self.addSubview(emailBar)
        self.addSubview(passwordBar)
        self.addSubview(loginButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        //MARK: plantIcon Constraints
        let backImage = ContentFitImageView()
        backImage.image = UIImage(named: "flower-back")
        backImage.setSuperview(self).addTop(constant: 20).addRight().addLeft().addHeight(withConstant: 300).done()
        plantIcon.setSuperview(self).done()
        plantIcon.topAnchor.constraint(equalTo: topAnchor, constant: 120).isActive = true
        plantIcon.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        plantIcon.heightAnchor.constraint(equalToConstant: 150).isActive = true
        plantIcon.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let frontImage = ContentFitImageView()
        frontImage.image = UIImage(named: "flower-front")
        frontImage.setSuperview(self).addTop(constant: 50).addRight(constant: -50).addLeft(constant: 50).addHeight(withConstant: 270).done()

        //MARK: emailBar Constraints
        emailBar.addCorners(7).done()

        ShadowUIView(radius: 3, subLayer: emailBar).setSuperview(self).addTop(anchor: plantIcon.bottomAnchor, constant: 80).addLeft(constant: 50).addRight(constant: -50).addHeight(withConstant: 50).done()

        
        //MARK: passwordBar Constraints
        passwordBar.addCorners(7).done()

        ShadowUIView(radius: 3, subLayer: passwordBar).setSuperview(self).addTop(anchor: emailBar.bottomAnchor, constant: 30).addLeft(constant: 50).addRight(constant: -50).addHeight(withConstant: 50).done()
        
        //MARK: loginButton Constraints
//        loginButton.topAnchor.constraint(equalTo: passwordBar.bottomAnchor, constant: 30).isActive = true
//        loginButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        loginButton.addCorners(15).done()
        
        loginButton.addCorners(10).done()

        ShadowUIView(radius: 2, subLayer: loginButton).setSuperview(self).addTop(anchor: passwordBar.bottomAnchor, constant: 30).addWidth(withConstant: 150).addHeight(withConstant: 50).centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
//        let view = UIView()
        let gradientView = CAGradientLayer()
        gradientView.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        gradientView.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientView.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientView.colors = [UIColor(hex: 0x302F82).cgColor, UIColor(hex: 0x5D5DB8).cgColor]
        loginButton.layer.addSublayer(gradientView)
        
    }
    
}
