//
//  SettingsViewController.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-12.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit
class SettingsViewController: UIViewController {
    var buttonList: [UIButton] = []
    var overlayList: [UIView] = []
    var delegate: ChangeColourDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = SettingsView()
        buttonList.append(newView.colourOptionOne)
        buttonList.append(newView.colourOptionTwo)
        buttonList.append(newView.colourOptionThree)
        overlayList.append(newView.overlayOne)
        overlayList.append(newView.overlayTwo)
        overlayList.append(newView.overlayThree)

        for button in buttonList {
            button.addTarget(self, action: #selector(deleteButtonPressed), for: .touchUpInside)
        }
        self.view = newView
    }
    
    
    @objc func deleteButtonPressed(_ sender: UIButton) {
        print(sender.tag)
        switch (sender.tag){
        case 1:
            delegate.changedColour([UIColor(hex: 0xCFD9FF).cgColor, UIColor(hex: 0x4569D2).cgColor])
            UserDefaults.standard.set(0, forKey: "colour1")
        case 2:
            delegate.changedColour([UIColor(hex: 0xFFD258).cgColor, UIColor(hex: 0xFFB496).cgColor])
            UserDefaults.standard.set(1, forKey: "colour1")
        case 3:
            delegate.changedColour([UIColor(hex: 0xFFF2CE).cgColor, UIColor(hex: 0xFFD258).cgColor])
            UserDefaults.standard.set(2, forKey: "colour1")
        default:
            fatalError()
        }
        self.dismiss(animated: true, completion: nil)

    }
    
}
