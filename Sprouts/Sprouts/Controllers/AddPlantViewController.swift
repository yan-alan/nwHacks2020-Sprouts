//
//  AddPlantViewController.swift
//  Sprouts
//
//  Created by Wren Liang on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit


class AddPlantViewController: UIViewController, UITextFieldDelegate {
    var newView: AddPlantView!
    var tableView: UITableView!
    var responseArr: SearchResults = []
    var terrariumDelegate: AddPlantDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationController?.navigationBar.prefersLargeTitles = true
        
        newView = AddPlantView()
        tableView = newView.tableView
//        self.isModalInPresentation = true
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PlantTableViewCell.self, forCellReuseIdentifier: "cell")
        newView.searchButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        newView.dismissButton.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        newView.testButton.addTarget(self, action: #selector(testPressed), for: .touchUpInside)
        
        newView.searchBar.delegate = self
        //setup view, add self as action target
        
        self.view = newView
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedOutside))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    @objc func tappedOutside() {
        self.view.endEditing(true)
    }
    
    @objc func searchPressed() {
        
        if let searchText = newView.searchBar.text {
            print("Search for \(searchText)")
            callAPI(queryPhrase: searchText, requestType: RequestType.searchPlants)
        }
        
        
        
    }
    
    @objc func dismissPressed() {
        self.dismiss(animated: true, completion: {})
    }
    
    @objc func testPressed() {
        if let searchText = newView.searchBar.text {
            print("Getting plant with ID \(searchText)")
            callAPI(queryPhrase: searchText, requestType: RequestType.getFromID)
            
        }
    }
    
    func callAPI(queryPhrase: String, requestType: RequestType) {
        
        let url = NetworkUtil.makeURL(query: queryPhrase, request: requestType)
        if let apiURL = url {
            let dataTask = URLSession.shared.dataTask(with: apiURL) {
                (data, response, error) in
                if let error = error {
                    print(error)
                } else if let inData = data {
                    var searchData: SearchResults?
                    var plantData: DetailPlantData?
                    if (requestType == RequestType.searchPlants) {
                        searchData = try? JSONDecoder().decode(SearchResults.self, from: inData)
                    } else if (requestType == RequestType.getFromID) {
                        plantData = try? JSONDecoder().decode(DetailPlantData.self, from: inData)
                    }
                    
                    
                    DispatchQueue.main.async {
                        //completion handler
                        switch requestType {
                        case .searchPlants:
                            guard let data = searchData else {
                                return
                            }
                            self.responseArr = data
                            self.tableView.reloadData()
                            
                        case .getFromID:
                            if let data = plantData {
                                print(data)
                            }
                        }
                        
                    }
                }
            }
            dataTask.resume()
        }
        
    }

    
}

extension AddPlantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let customCell = cell as? PlantTableViewCell else {
            print("returning cell")
            return cell
        }
        
        customCell.scientificName.text = responseArr[indexPath.row].scientificName
        customCell.commonName.text = responseArr[indexPath.row].commonName
        return customCell
    }
    
    
}
    
    
