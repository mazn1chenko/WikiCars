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
    let infoAboutCompany = UILabel()
        
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
        
        infoAboutCompany.translatesAutoresizingMaskIntoConstraints = false
        infoAboutCompany.sizeToFit()
        infoAboutCompany.textAlignment = .center
        infoAboutCompany.textColor = .black
        
    }
    
    private func layout() {
        addSubview(imageOfBrandImage)
        addSubview(infoAboutCompany)
        
        NSLayoutConstraint.activate([
            imageOfBrandImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageOfBrandImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageOfBrandImage.heightAnchor.constraint(equalToConstant: frame.height / 1.1),
            imageOfBrandImage.widthAnchor.constraint(equalToConstant: frame.height / 1.1),
            
            infoAboutCompany.leadingAnchor.constraint(equalTo: imageOfBrandImage.trailingAnchor, constant: 10),
            infoAboutCompany.centerYAnchor.constraint(equalTo: centerYAnchor)

        ])
    }
    
    func configureCell(model: AllBrandsOfCars){
        infoAboutCompany.text = model.descriptionOfBrand
        
        APIManager.shared.gettingImageOfBrands(picName: model.brandName) { image in
            DispatchQueue.main.async {
                self.imageOfBrandImage.image = image
            }
        }
    }
}

