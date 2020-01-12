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
    }
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        commonName.setSuperview(self).addTop().addRight(constant: -10).addLeft(constant: 10).addHeight(withConstant: 30).setColor(.red)
        scientificName.setSuperview(self).addTop(anchor: commonName.bottomAnchor, constant: 10).addRight(constant: -10).addLeft(constant: 10).addHeight(withConstant: 30).setColor(.green)

    }
    
}
