//
//  MainPageCollectionViewCell.swift
//  WikiCars
//
//  Created by m223 on 29.06.2023.
//

import UIKit

class MainPageTableViewCell: UITableViewCell {
    
    static let reuseID = "CustomTableViewCell"
    
    let imageOfBrandImage = UIImageView()
    var infoAboutCompany: AllBrandsOfCars?
    var nameOfBrandLabel = UILabel()
    let infoAboutCompanyButton = UIButton(type: .infoDark)
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .darkGray
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        imageOfBrandImage.translatesAutoresizingMaskIntoConstraints = false
        imageOfBrandImage.backgroundColor = .darkGray
   
        infoAboutCompanyButton.translatesAutoresizingMaskIntoConstraints = false
        infoAboutCompanyButton.sizeToFit()
        infoAboutCompanyButton.addTarget(self, action: #selector(getInfoButton(action:)), for: .touchUpInside)
        
        nameOfBrandLabel.translatesAutoresizingMaskIntoConstraints = false
        nameOfBrandLabel.sizeToFit()
        nameOfBrandLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    private func layout() {
        addSubview(imageOfBrandImage)
        addSubview(infoAboutCompanyButton)
        addSubview(nameOfBrandLabel)
        
        NSLayoutConstraint.activate([
            imageOfBrandImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageOfBrandImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageOfBrandImage.heightAnchor.constraint(equalToConstant: frame.height / 0.85),
            imageOfBrandImage.widthAnchor.constraint(equalToConstant: frame.height / 0.85),

            infoAboutCompanyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            infoAboutCompanyButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameOfBrandLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameOfBrandLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    //MARK: - Objc func
    
    @objc func getInfoButton(action: UIButton){
        
        showAlert(title: infoAboutCompany?.brandName ?? "NoInternet", message: infoAboutCompany?.descriptionOfBrand ?? "NoInternet")
        
    }
    
    func showAlert(title: String, message: String) {
        if let viewController = findViewController() {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            responder = responder?.next
        }
        return nil
    }
    
    func configureCell(model: AllBrandsOfCars){
        
        self.infoAboutCompany = model
        
        nameOfBrandLabel.text = model.brandName
        
        APIManager.shared.gettingImageOfBrands(picName: model.brandName) { image in
            DispatchQueue.main.async {
                self.imageOfBrandImage.image = image
            }
        }
    }
}

