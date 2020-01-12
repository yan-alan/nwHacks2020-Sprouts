//
//  SetTimeToWaterViewController.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-12.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit


class SetTimeToWaterViewController: UIViewController, UITextFieldDelegate {
    var terrariumDelegate: AddPlantDelegate?
    var textField: UITextField!
    var addButton: UIButton!
    private var waterCount = 1
    var model: Plant!
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = SetTimeToWaterView()
        newView.model = model
        addButton = newView.addButton
        addButton.addTarget(self, action: #selector(setPlantModel), for: .touchUpInside)
        textField = newView.searchBar
        textField.delegate = self
        self.view = newView
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedOutside))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(string != "") {
            guard let seconds = Int(string) else {
                addButton.userDefinedConstraintDict["height"]?.constant = 0
                UIView.animate(withDuration: 0.4) {
                    self.view.layoutIfNeeded()
                }
                return false
            }
            if(textField.text == "") {
                addButton.userDefinedConstraintDict["height"]?.constant = 50
                UIView.animate(withDuration: 0.4) {
                    self.view.layoutIfNeeded()
                }
            } 
        }
        else {
            if(textField.text?.count == 1) {
                addButton.userDefinedConstraintDict["height"]?.constant = 0
                UIView.animate(withDuration: 0.4) {
                    self.view.layoutIfNeeded()
                }
            }
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    @objc func tappedOutside() {
        self.view.endEditing(true)
    }
    @objc func setPlantModel() {
        model.wateringInterval = Int(textField.text!)!
        
        let iconName = createImageName(model)
        model.pictureName = iconName
        
        terrariumDelegate!.addToPlantsArray(data: model)
        self.dismiss(animated: true, completion: nil)
    }
    
    func createImageName(_ model: Plant) -> String {
        var plantDictionary: [String: String]
        plantDictionary = ["Helianthus": "sunflower"]
        plantDictionary["Eriophyllum"] = "sunflower"
        
        plantDictionary["Phyllostachys"] = "bamboo"
        plantDictionary["Bambusa"] = "bamboo"
        
        plantDictionary["Tulipa"] = "tulip"
        plantDictionary["Moraea"] = "tulip"
        
        plantDictionary["Aloe"] = "aloe"
        
        let plantScienceName = model.scientificName
        var iconSuffix = "default"
        
        for (key, value) in plantDictionary {
            if (plantScienceName.contains(key)) {
                iconSuffix = value
                break;
            }
        }
        
        var iconName = "plant-"
        iconName.append(iconSuffix)
        
        print(iconName)
        
        return iconName
    }
}
