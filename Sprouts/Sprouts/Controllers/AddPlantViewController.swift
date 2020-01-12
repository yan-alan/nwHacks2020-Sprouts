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
    var waterImageView: UIImageView!
    private var waterCount = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationController?.navigationBar.prefersLargeTitles = true
        
        newView = AddPlantView()
        tableView = newView.tableView
        waterImageView = newView.wateringImage
//        self.isModalInPresentation = true
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PlantTableViewCell.self, forCellReuseIdentifier: "cell")
        newView.searchButton.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        newView.dismissButton.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        
        newView.searchBar.delegate = self
        //setup view, add self as action target
        reloadTableView()
        self.view = newView
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedOutside))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        
        let _ = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(cycleImage), userInfo: nil, repeats: true)
    }
    func reloadTableView() {
        if(responseArr.count == 0) {
            tableView.isHidden = true
        } else {
            waterImageView.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        }
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
    @objc func cycleImage() {
        waterImageView.image = UIImage(named: "watering-\(waterCount)")
        waterCount += 1
        if waterCount > 6 {
            waterCount = 1
        }
    }
    func callAPI(queryPhrase: String, requestType: RequestType) {
        tableView.isHidden = true
        waterCount = 1
        waterImageView.isHidden = false
        let url = NetworkUtil.makeURL(query: queryPhrase, request: requestType)
        if let apiURL = url {
            print(apiURL)
            let dataTask = URLSession.shared.dataTask(with: apiURL) {
                (data, response, error) in
                if let error = error {
                    print(error)
                } else if let inData = data {
                    print(inData)
                    var searchData: SearchResults?
                    var plantData: Plant?
                    if (requestType == RequestType.searchPlants) {
                        searchData = try? JSONDecoder().decode(SearchResults.self, from: inData)
                    } else if (requestType == RequestType.getFromID) {
//                        plantData = try? JSONDecoder().decode(Plant.self, from: inData)
                        print(plantData)
                    }
                    
                    
                    DispatchQueue.main.async {
                        //completion handler
                        switch requestType {
                        case .searchPlants:
                            guard let data = searchData else {
                                return
                            }
                            self.responseArr = data
                            self.reloadTableView()
                            
                        case .getFromID:
                            if let data = plantData {
                                print(data)
                                self.terrariumDelegate?.appendToArray(data: data)
                                self.dismiss(animated: true, completion: nil)
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
        if(responseArr[indexPath.row].commonName == nil) {
            responseArr[indexPath.row].commonName = "No Name"
        }
        customCell.scientificName.text = responseArr[indexPath.row].scientificName
        customCell.commonName.text = responseArr[indexPath.row].commonName
        customCell.id = responseArr[indexPath.row].id
        return customCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        terrariumDelegate?.appendToArray(data: Plant(responseArr[indexPath.row].commonName!, responseArr[indexPath.row].commonName!, wateringInterval: 60))
        dismiss(animated: true, completion: nil)
    }
    
    
}
    
