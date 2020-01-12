//
//  AddPlantViewController.swift
//  Sprouts
//
//  Created by Wren Liang on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit


class AddPlantViewController: UIViewController {
    var newView: AddPlantView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationController?.navigationBar.prefersLargeTitles = true
        
        newView = AddPlantView()
        
        newView.searchButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        newView.dismissButton.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        
        //setup view, add self as action target
        
        self.view = newView
    }
    
    
    @objc func searchPressed() {
        
        if let searchText = newView.searchBar.text {
            print("Search for \(searchText)")
            NetworkUtil.callAPI(queryPhrase: searchText, requestType: RequestType.searchPlants)
        }
        
        
        
    }
    
    @objc func dismissPressed() {
        
    }

    
}




//
//extension AddPlantViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell")
//        
//    }
//    
//    
//}
    
    
