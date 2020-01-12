//
//  DetailedPlantViewController.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit

class DetailedPlantViewController: UIViewController {
    var model: Plant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = DetailedPlantView()
        
        newView.plantIcon.image = UIImage(named: model.pictureName)
        
        newView.model = model
        self.view = newView
    }
    
    
    
    
}
