//
//  CarInfoViewController.swift
//  WikiCars
//
//  Created by m223 on 01.07.2023.
//

import UIKit

class CarInfoViewController: UIViewController {
    
    let imageOfCarImageView = UIImageView()
    let descriptionOfCarLabel = UILabel()
    
    var brand: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        network()
    }
    
    func setup() {
        
        imageOfCarImageView.translatesAutoresizingMaskIntoConstraints = false
        imageOfCarImageView.layer.cornerRadius = 10
        
        descriptionOfCarLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionOfCarLabel.textAlignment = .center
        descriptionOfCarLabel.numberOfLines = 0
        
        
    }
    
    func layout() {
        view.addSubview(imageOfCarImageView)
        view.addSubview(descriptionOfCarLabel)
        
        NSLayoutConstraint.activate([
            
            imageOfCarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            imageOfCarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            imageOfCarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            imageOfCarImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.frame.height / 1.9)),

            
            
            descriptionOfCarLabel.topAnchor.constraint(equalTo: imageOfCarImageView.bottomAnchor, constant: 5),
            descriptionOfCarLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            descriptionOfCarLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
            
        ])
        
    }
    
    func network() {
        
        APIManager.shared.getImageOfCar(picName: title ?? "default") { image in
            DispatchQueue.main.async {
                self.imageOfCarImageView.image = image
            }
        }
        
        APIManager.shared.getParticularModelInfo(collection1: "DataOfCars", docName: brand ?? "", collection2: "ParticularTypeOfCars", docName2: title ?? "", completion: { AllData in
            for i in AllData {
                if i.name == self.title {
                    DispatchQueue.main.async {
                        self.descriptionOfCarLabel.text = i.desription
                    }
                }
            }
        })
        
    }
    
}
