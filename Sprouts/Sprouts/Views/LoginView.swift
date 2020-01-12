//
//  LoginView.swift
//  Sprouts
//
//  Created by Wren Liang on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    lazy var gradientView = CAGradientLayer()
    
    lazy var plantIcon: UIImageView = {
        let image = UIImageView()
        
        image.layer.masksToBounds = true
        image.layer.borderWidth = 0
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.image = UIImage(named: "plant-default")
        
        return image
    }()
    
    lazy var emailBar: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.text = ""
        textField.autocapitalizationType = .none
        
        textField.borderStyle = UITextField.BorderStyle.bezel
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
        
        textField.borderStyle = UITextField.BorderStyle.bezel
        textField.textAlignment = .center
        textField.backgroundColor = .white
        
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(hex: 0x302F82)
        button.setTitleColor(UIColor.black, for: .normal)
        
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
        
        self.addSubview(plantIcon)
        self.addSubview(emailBar)
        self.addSubview(passwordBar)
        self.addSubview(loginButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        //MARK: plantIcon Constraints
        plantIcon.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -150).isActive = true
        plantIcon.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        plantIcon.heightAnchor.constraint(equalToConstant: 150).isActive = true
        plantIcon.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //MARK: emailBar Constraints
        emailBar.topAnchor.constraint(equalTo: plantIcon.bottomAnchor, constant: 100).isActive = true
        emailBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        emailBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        emailBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailBar.addCorners(15).done()
        
        //MARK: passwordBar Constraints
        passwordBar.topAnchor.constraint(equalTo: emailBar.bottomAnchor, constant: 50).isActive = true
        passwordBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 50).isActive = true
        passwordBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -50).isActive = true
        passwordBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordBar.addCorners(15).done()
        
        //MARK: loginButton Constraints
        loginButton.topAnchor.constraint(equalTo: passwordBar.bottomAnchor, constant: 50).isActive = true
        loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 75).isActive = true
        loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -75).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.addCorners(15).done()
        
    }
    
}
