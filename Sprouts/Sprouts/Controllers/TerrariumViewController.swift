//
//  TerrariumViewController.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit
import AlanYanHelpers
class TerrariumViewController: UIViewController {
    var collectionView: UICollectionView!
    var plants: [Plant] = []
    var toEdit = false {
        didSet{
            collectionView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
        collectionView.reloadData()
        print("pls")
        
        handleMyBars()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = TerrariumView()
        collectionView = newView.collectionView
//        for i in 0..<12 {
//            plants.append(Plant(name: "Rose", scientificName: "Quantum Deternum", wateringInterval: 60, recieveNotification: true))
//        }
        if(plants.count >= 3) {
            for i in 1...plants.count/3 {
                let imageView = ContentFitImageView(frame: CGRect(x: 0, y: (i*165 + (i-1)*30 - 2), width: (Int(UIScreen.main.bounds.size.width-70)), height: 14))
        
                imageView.image = UIImage(named: "shelf")
                collectionView.addSubview(imageView)
            }
        }
        newView.notificationButton.addTarget(self, action: #selector(setEdit), for: .touchUpInside)
        newView.addButton.addTarget(self, action: #selector(presentAdd), for: .touchUpInside)
        //Collection View Delegation
        newView.collectionView.delegate = self
        newView.collectionView.dataSource = self
        newView.collectionView.register(TerrariumCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        #warning("Must change this to stored data!")
        for _ in 0..<12 {
         //   plants.append()
        }
        print("here")
        
        newView.settingsButton.addTarget(self, action: #selector(testLogin), for: .touchUpInside)
        
        self.view = newView
    }
    
    @objc func testLogin() {
        let modalVC = LoginViewController()
        
        modalVC.modalPresentationStyle = .fullScreen
        
        self.present(modalVC, animated: true, completion: {})
        
    }

    @objc func setEdit() {
        toEdit = !toEdit
    }
    func handleMyBars() {
        for i in 1...(plants.count/3+1) {
            let imageView = ContentFitImageView(frame: CGRect(x: 0, y: (i*165 + (i-1)*30 - 2), width: (Int(UIScreen.main.bounds.size.width-70)), height: 14))
    
            imageView.image = UIImage(named: "shelf")
            collectionView.addSubview(imageView)
        }
    }
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
    
    @objc func presentAdd() {
        let pushVC = AddPlantViewController()
        pushVC.terrariumDelegate = self
        present(pushVC, animated: true, completion: nil)
    }
}

extension TerrariumViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           
           // 1
           // return the number of sections
           return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.26, height: 165)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let collectionCell = cell as? TerrariumCollectionViewCell else {
            return cell
        }
        collectionCell.plantImage.image = UIImage(named: plants[indexPath.item].pictureName)
        collectionCell.myWaterButtonDelegate = self
        collectionCell.waterButton.tag = indexPath.item
        if(Date() < plants[indexPath.item].nextWaterDate!) {
            let distance = Date().distance(to: plants[indexPath.item].nextWaterDate!)
            print(Date().distance(to: plants[indexPath.item].nextWaterDate!))
            collectionCell.waterButton.isHidden = true
            collectionCell.dayLabel.isHidden = false
            collectionCell.dayLabel.text = String((Int(distance)/3600))
        } else {
            print("Here")
            collectionCell.dayLabel.isHidden = true
            collectionCell.waterButton.isHidden = false

        }
        print("here")
        if(toEdit) {
            if(plants[indexPath.item].recieveNotification) {
                collectionCell.imageView.image = UIImage(named: "selected")
            } else {
                collectionCell.imageView.image = UIImage(named: "selected")
            }
            collectionCell.imageView.isHidden = false
        } else {
            collectionCell.imageView.isHidden = true
        }
        return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(toEdit) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? TerrariumCollectionViewCell else {
                return
            }
            if(cell.imageView.image == UIImage(named: "hollow")) {
                plants[indexPath.item].recieveNotification = true
                cell.imageView.image = UIImage(named: "selected")
            } else {
                plants[indexPath.item].recieveNotification = false
                cell.imageView.image = UIImage(named: "hollow")
                #warning("Must do notification cancelling here")
            }
        } else {
            let presentVC = DetailedPlantViewController()
            
            presentVC.model = plants[indexPath.item]
            present(presentVC, animated: true, completion: nil)
        }
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("Changing the cell order, moving: \(sourceIndexPath.row) to \(destinationIndexPath.row)")
        #warning("Need to modify list after")
    }
}

extension TerrariumViewController: AddPlantDelegate {
    func appendToArray(data: Plant) {
        let newVC = SetTimeToWaterViewController()
        newVC.model = data
        newVC.terrariumDelegate = self
        present(newVC, animated: true, completion: nil)
    }
    func addToPlantsArray(data: Plant) {
        var plant = data
        plant.nextWaterDate = Date().addingTimeInterval(TimeInterval(exactly: data.wateringInterval)!)
        CreateNotification.schedule(for: plant)
        self.plants.append(plant)
        collectionView.reloadData()
        handleMyBars()
    }
    
}

protocol AddPlantDelegate {
    func appendToArray(data: Plant)
    func addToPlantsArray(data: Plant)
}

extension TerrariumViewController: WaterButtonDelegate {
    func pressedButtonAt(_ index: Int) {
        print(index)
        plants[index].nextWaterDate = Date().addingTimeInterval(TimeInterval(exactly: plants[index].wateringInterval)!)
        CreateNotification.schedule(for: plants[index])
        collectionView.reloadData()
    }
}

protocol WaterButtonDelegate {
    func pressedButtonAt(_ index: Int)
}


import SwiftUI


struct ControllerPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        typealias UIViewControllerType = UIViewController

        func makeUIViewController(context: UIViewControllerRepresentableContext<ControllerPreview.ContainerView>) -> ControllerPreview.ContainerView.UIViewControllerType {
            return TerrariumViewController()
        }

        func updateUIViewController(_ uiViewController: ControllerPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ControllerPreview.ContainerView>) {

        }
    }
}




