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
    var model: Plant? {
        didSet {
            //do work in the view once the plant is set
        }
    }
    
    override func setupView() {
        backgroundColor = .green
    }
}
