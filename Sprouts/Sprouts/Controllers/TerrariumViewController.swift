//
//  TerrariumViewController.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit

class TerrariumViewController: UIViewController {
    var collectionView: UICollectionView!
    var plants: [Plant] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = TerrariumView()
        collectionView = newView.collectionView

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
        
        self.view = newView
    }
    override func viewWillAppear(_ animated: Bool) {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
        collectionView.reloadData()
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
        return CGSize(width: 100, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        guard let collectionCell = cell as? TerrariumCollectionViewCell else {
            return cell
        }
        print("here")
        return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let presentVC = DetailedPlantViewController()
        
        //presentVC.model = plants[indexPath.item]
        present(presentVC, animated: true, completion: nil)
        
        //navigationController?.pushViewController(presentVC, animated: true)
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
        self.plants.append(data)
        collectionView.reloadData()
    }
    
}


protocol AddPlantDelegate {
    func appendToArray(data: Plant)
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




