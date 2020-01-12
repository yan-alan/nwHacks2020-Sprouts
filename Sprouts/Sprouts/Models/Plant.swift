//
//  Plant.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import Foundation

struct Plant {
    var name: String
    var scientificName: String
    var pictureName: String?
    var wateringInterval: Int
    var nextWaterDate: Date?
    
    init(_ name: String, _ scientificName: String, wateringInterval: Int) {
        self.name = name
        self.scientificName = scientificName
        self.wateringInterval = wateringInterval
    }
}

//credit Quicktype
