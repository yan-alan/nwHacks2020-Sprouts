//
//  TerrariumViewController.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import UIKit
import AlanYanHelpers
import SpriteKit

class TerrariumViewController: UIViewController {
    var collectionView: UICollectionView!
    var plants: [Plant] = []
    var toEdit = false {
        didSet{
            collectionView.reloadData()
        }
    }
    var skView: SKView?
    var gradientView: CAGradientLayer!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
        collectionView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveData(_:)), name: NSNotification.Name(rawValue: "ReceiveData"), object: nil)

        print("pls")
        
        handleMyBars()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReceiveData"), object: nil)

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
        gradientView = newView.gradientView
        newView.notificationButton.addTarget(self, action: #selector(setEdit), for: .touchUpInside)
        newView.addButton.addTarget(self, action: #selector(presentAdd), for: .touchUpInside)
        newView.settingsButton.addTarget(self, action: #selector(presentSettings), for: .touchUpInside)
        //Collection View Delegation
        newView.collectionView.delegate = self
        newView.collectionView.dataSource = self
        newView.collectionView.register(TerrariumCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        print("here")
                
        if(UserDefaults.standard.integer(forKey: "firstTime") == 0) {
            openLogin()
        }
        
        
        self.view = newView
//        
//        skView = SKView(frame: newView.frame)
//        skView!.presentScene(SKScene())
//        self.view.addSubview(skView!)
    }
    @objc func onReceiveData(_ notification:Notification) {
        collectionView.reloadData()
    }
    
    func openLogin() {
        let modalVC = LoginViewController()
        modalVC.modalPresentationStyle = .fullScreen
        
        self.present(modalVC, animated: true, completion: {})
        
    }

    @objc func setEdit() {
        toEdit = !toEdit
    }
    func handleMyBars() {
        var count = 1
        if(plants.count % 3 == 0) {
            count = 0
        }
        if(plants.count > 0) {
            for i in 1...(plants.count/3+count) {
                
                let imageView = ContentFitImageView(frame: CGRect(x: 0, y: (i*165 + (i-1)*30 - 2), width: (Int(UIScreen.main.bounds.size.width-70)), height: 14))
        
                imageView.image = UIImage(named: "shelf")
                collectionView.addSubview(imageView)
            }
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
    @objc func presentSettings() {
        let pushVC = SettingsViewController()
        pushVC.delegate = self
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
//        
//        var emitter = newWaterEmitter()
//        emitter?.position = CGPoint(x: collectionCell.frame.midX, y: collectionCell.frame.midY)
//        
//        skView?.scene?.addChild(emitter!)
//        
//        print(skView?.scene?.children)
//        
//        if let emmiter = SKEmitterNode(fileNamed: "WaterParticles") {
//            skView?.scene?.addChild(emmiter)
//            skView?.presentScene(skView?.scene)
//        }
        
        collectionCell.plantImage.image = UIImage(named: plants[indexPath.item].pictureName)
        collectionCell.myWaterButtonDelegate = self
        collectionCell.waterButton.tag = indexPath.item
        if(Date() < plants[indexPath.item].nextWaterDate!) {
            let distance = Date().distance(to: plants[indexPath.item].nextWaterDate!)
            print(Date().distance(to: plants[indexPath.item].nextWaterDate!))
            collectionCell.waterButton.isHidden = true
            collectionCell.dayLabel.isHidden = false
            let value = Int(distance)/3600
            if(value == 0) {
                collectionCell.dayLabel.text = "Today"
            } else {
                collectionCell.dayLabel.text = "\(value) days"
            }
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
                collectionCell.imageView.image = UIImage(named: "hollow")
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
            presentVC.storedIndex = indexPath.item
            presentVC.delegate = self
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
        let item = plants[sourceIndexPath.item]
        plants.remove(at: sourceIndexPath.item)
        plants.insert(item, at: destinationIndexPath.item)
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
    func deletePlant(index: Int) {
        plants.remove(at: index)
        collectionView.reloadData()
    }
    
}
protocol AddPlantDelegate {
    func appendToArray(data: Plant)
    func addToPlantsArray(data: Plant)
    func deletePlant(index: Int)
}

extension TerrariumViewController: WaterButtonDelegate {
    func pressedButtonAt(_ index: Int) {
        print(index)
        guard let cell = self.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? TerrariumCollectionViewCell else {
            print("returning")
            return
        }

        UIView.animate(withDuration: 0.4, animations: {
            cell.waterButton.transform = CGAffineTransform(translationX: 0, y: 50)
        }, completion: { (val) in
            cell.waterImage.image = UIImage(named: "drop-finish")

            UIView.animate(withDuration: 0.3, animations: {
                cell.waterButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.2)
                cell.waterButton.alpha = 0
            }, completion: { (val) in
                cell.waterImage.image = UIImage(named: "waterdrop")
                cell.waterButton.alpha = 1
                self.collectionView.reloadData()
                cell.waterButton.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.waterButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

            })
        })
        plants[index].nextWaterDate = Date().addingTimeInterval(TimeInterval(exactly: plants[index].wateringInterval)!)
        if(plants[index].recieveNotification) {
            CreateNotification.schedule(for: plants[index])
        }
    }
}
extension TerrariumViewController: ChangeColourDelegate {
    func changedColour(_ colours: [CGColor]) {
        gradientView.colors = colours
    }
}
protocol ChangeColourDelegate {
    func changedColour(_ colours: [CGColor])
}
protocol WaterButtonDelegate {
    func pressedButtonAt(_ index: Int)
}

extension TerrariumViewController {
    func newWaterEmitter() -> SKEmitterNode? {
        return SKEmitterNode(fileNamed: "WaterParticles")
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




