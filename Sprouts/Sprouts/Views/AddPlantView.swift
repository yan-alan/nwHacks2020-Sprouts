//
//  AddPlantView.swift
//  Sprouts
//
//  Created by Wren Liang on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit


class AddPlantView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    

    
    lazy var plantIcon: UIImageView = {
        let image = UIImageView()
        
        image.layer.masksToBounds = true
        image.layer.borderWidth = 2.0
        
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.backgroundColor = .purple
        
        return image
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: .normal)
        
        return button
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Dismiss", for: .normal)
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.white, for: .normal)
        
        return button
    }()
    
    lazy var searchBar: UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search for a plant!"
        textField.text = ""
        
        textField.borderStyle = UITextField.BorderStyle.bezel
        textField.textAlignment = .center
        
        return textField
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.addSubview(titleLabel)
        self.addSubview(plantIcon)
        self.addSubview(searchBar)
        self.addSubview(searchButton)
        self.addSubview(dismissButton)
        self.addSubview(tableView)
        setupConstraints()
    }
    
    //MARK: - Constraints Setup
    private func setupConstraints(){
        //MARK: titleLabel Constraints
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        
        //MARK: plantIcon Constraints
        plantIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
        plantIcon.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        plantIcon.heightAnchor.constraint(equalToConstant: 100).isActive = true
        plantIcon.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        //MARK: searchBar Constraints
        searchBar.topAnchor.constraint(equalTo: plantIcon.bottomAnchor, constant: 50).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchBar.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        searchBar.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        
        //MARK: searchButton Constraints
        searchButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 50).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        //MARK: Table View Constraints
        tableView.topAnchor.constraint(equalTo: centerYAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
 
    }
}
