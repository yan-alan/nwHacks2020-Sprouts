//
//  PlantTableViewCell.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit
import AlanYanHelpers

class PlantTableViewCell: UITableViewCell {
    lazy var commonName = UILabel()
    lazy var scientificName = UILabel()
    
    var id: Int?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        commonName.setSuperview(self).addTop().addRight(constant: -20).addLeft(constant: 20).addHeight(withConstant: 30).done()
        scientificName.setSuperview(self).addTop(anchor: commonName.bottomAnchor, constant: 2).addRight(constant: -20).addLeft(constant: 20).addHeight(withConstant: 30).done()
        commonName.setFont(name: "Futura-Bold", size: 20)
        scientificName.setFont(name: "Futura", size: 13)

    }
    
}
