//
//  AddPlantViewController.swift
//  Sprouts
//
//  Created by Wren Liang on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit


class AddPlantViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let newView = AddPlantView()
        
        newView.searchButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        
        //setup view, add self as action target
        
        self.view = newView
    }
    
    
    @objc func searchPressed() {
        
    }
    
}

extension AddPlantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
    
    
