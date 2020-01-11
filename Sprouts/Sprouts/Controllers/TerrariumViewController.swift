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
    override func viewDidLoad() {
        super.viewDidLoad()
        let newView = TerrariumView()
        collectionView = newView.collectionView
        newView.addButton.addTarget(self, action: #selector(presentAdd), for: .touchUpInside)
        //Collection View Delegation
        newView.collectionView.delegate = self
        newView.collectionView.dataSource = self
        newView.collectionView.register(TerrariumCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        print("here")
        
        self.view = newView
    }
    
    @objc func presentAdd() {
        let pushVC = AddPlantViewController()
        present(pushVC, animated: true, completion: nil)
    }
}

extension TerrariumViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
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
        presentVC.model = Plant()
        #warning("Need to give a proper model")
        navigationController?.pushViewController(presentVC, animated: true)
    }
    
    
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


