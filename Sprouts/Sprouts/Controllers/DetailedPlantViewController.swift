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
    var storedIndex: Int!
    var delegate: AddPlantDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = DetailedPlantView()
        
        newView.plantIcon.image = UIImage(named: model.pictureName)
        let days = Int(model.wateringInterval)/3600
        if days == 0 {
            newView.waterAmountLabel.text = "Every day"
        } else {
            newView.waterAmountLabel.text = "Every \(days) days"
        }
        newView.deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        newView.model = model
        self.view = newView
    }
    
    
    @objc func deleteButtonPressed() {
        let alert = UIAlertController(title: "Delete Plant?", message: "Are you sure you want to delete", preferredStyle: .alert)
        var action = UIAlertAction(title: "Delete", style: .destructive) { (UIAlertAction) in
            self.delegate.deletePlant(index: self.storedIndex)
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        action = UIAlertAction(title: "Cancel", style: .cancel) { (UIAlertAction) in
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
