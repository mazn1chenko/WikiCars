//
//  MainPageCollectionViewCell.swift
//  WikiCars
//
//  Created by m223 on 29.06.2023.
//

import UIKit

class MainPageCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "CustomCollectionViewcell"
    
    let imageOfBrandImage = UIImageView()
    let nameOfBrandLabel = UILabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .darkGray
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        imageOfBrandImage.translatesAutoresizingMaskIntoConstraints = false
        imageOfBrandImage.backgroundColor = .darkGray
        
        nameOfBrandLabel.translatesAutoresizingMaskIntoConstraints = false
        nameOfBrandLabel.sizeToFit()
        nameOfBrandLabel.textAlignment = .center
        nameOfBrandLabel.textColor = .black
        
    }
    
    func layout() {
        addSubview(imageOfBrandImage)
        addSubview(nameOfBrandLabel)
        
        NSLayoutConstraint.activate([
            imageOfBrandImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageOfBrandImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageOfBrandImage.heightAnchor.constraint(equalToConstant: frame.height / 2),
            imageOfBrandImage.widthAnchor.constraint(equalToConstant: frame.height / 2),
            
            
            nameOfBrandLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameOfBrandLabel.topAnchor.constraint(equalTo: imageOfBrandImage.bottomAnchor, constant: 5)
        
        ])
        
    }
    
    func configureCell(nameOfBrand: String){
        
        nameOfBrandLabel.text = nameOfBrand
        print(nameOfBrand)
        APIManager.shared.gettingImageOfBrands(picName: nameOfBrand) { image in
            DispatchQueue.main.async {
                self.imageOfBrandImage.image = image
                
            }
        }
        
    }
    
    
}
