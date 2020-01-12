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
    var pictureName: String
    var wateringInterval: Int
    var nextWaterDate: Date?
    var recieveNotification: Bool
    
    init(name: String, scientificName: String, wateringInterval: Int, recieveNotification: Bool, pictureName: String? = "default") {
        self.name = name
        self.scientificName = scientificName
        self.wateringInterval = wateringInterval
        self.recieveNotification = recieveNotification
        self.pictureName = pictureName!
    }
}

//credit Quicktype
