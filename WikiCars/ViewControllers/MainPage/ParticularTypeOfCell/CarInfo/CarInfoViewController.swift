//
//  CarInfoViewController.swift
//  WikiCars
//
//  Created by m223 on 01.07.2023.
//

import UIKit
import SafariServices

class CarInfoViewController: UIViewController {
    
    let imageOfCarImageView = UIImageView()
    let descriptionOfCarLabel = UILabel()
    let siteOfModelButton = UIButton()
    var siteOfModelhttp: String?
    
    var brand: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        network()
    }
    
    private func setup() {
        
        imageOfCarImageView.translatesAutoresizingMaskIntoConstraints = false
        imageOfCarImageView.layer.cornerRadius = 10
        imageOfCarImageView.clipsToBounds = true 
        imageOfCarImageView.isUserInteractionEnabled = true
        
        descriptionOfCarLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionOfCarLabel.textAlignment = .center
        descriptionOfCarLabel.numberOfLines = 0
        
        siteOfModelButton.translatesAutoresizingMaskIntoConstraints = false
        siteOfModelButton.setTitle("Детальніше про модель", for: .normal)
        siteOfModelButton.addTarget(self, action: #selector(openSafariButtonTapped), for: .touchUpInside)
        siteOfModelButton.backgroundColor = .orange
        siteOfModelButton.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageOfCarImageView.addGestureRecognizer(tapGesture)
        
    }
    
    private func layout() {
        view.addSubview(imageOfCarImageView)
        view.addSubview(descriptionOfCarLabel)
        view.addSubview(siteOfModelButton)
        
        NSLayoutConstraint.activate([
            
            imageOfCarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            imageOfCarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            imageOfCarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            imageOfCarImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(view.frame.height / 1.9)),
            
            descriptionOfCarLabel.topAnchor.constraint(equalTo: imageOfCarImageView.bottomAnchor, constant: 5),
            descriptionOfCarLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            descriptionOfCarLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            siteOfModelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            siteOfModelButton.topAnchor.constraint(equalTo: descriptionOfCarLabel.bottomAnchor, constant: 5),
            siteOfModelButton.heightAnchor.constraint(equalToConstant: 25),
            siteOfModelButton.widthAnchor.constraint(equalToConstant: view.frame.width / 1.75)
            
        ])
        
    }
    
    private func network() {
        
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
                        self.siteOfModelhttp = i.siteOfModel
                    }
                }
            }
        })
        
        
    }
    
    //MARK: - Objc func
    
    @objc func imageTapped() {
        let zoomedImage = UIImageView(image: imageOfCarImageView.image)
        zoomedImage.frame = view.bounds
        zoomedImage.contentMode = .scaleAspectFit
        zoomedImage.backgroundColor = .black
        zoomedImage.layer.cornerRadius = 10
        zoomedImage.backgroundColor = .lightGray.withAlphaComponent(0.99)
        zoomedImage.isUserInteractionEnabled = true
        zoomedImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissZoomedView)))
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(scaleZoomedView(_:)))
        zoomedImage.addGestureRecognizer(pinchGesture)
        
        view.addSubview(zoomedImage)
    }
    
    @objc func dismissZoomedView() {
        view.subviews.last?.removeFromSuperview()
    }
    
    @objc func scaleZoomedView(_ sender: UIPinchGestureRecognizer) {
        guard let zoomedImage = sender.view as? UIImageView else {
            return
        }

        if sender.state == .changed {
            let currentScale = zoomedImage.frame.size.width / zoomedImage.bounds.size.width
            let newScale = currentScale * sender.scale
            
            if newScale > 1.0 && newScale < 3.0 { 
                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                zoomedImage.transform = transform
            }
            
            sender.scale = 1.0
        }
    }
    
    @IBAction func openSafariButtonTapped(_ sender: UIButton) {
                
        guard let url = URL(string: "\(siteOfModelhttp ?? "www.google.com")") else {
            return
        }
        
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .fullScreen
        present(safariViewController, animated: true, completion: nil)
    }
    
}
