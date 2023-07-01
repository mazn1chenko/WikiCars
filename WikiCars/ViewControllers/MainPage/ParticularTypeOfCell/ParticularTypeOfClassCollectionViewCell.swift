//
//  ParticularTypeOfClassCollectionViewCell.swift
//  WikiCars
//
//  Created by m223 on 01.07.2023.
//

import UIKit

class ParticularTypeOfClassCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "CustomCollectionViewcell"
    
    let imageOfBrandImage = UIImageView()
    let nameOfBrandLabel = UILabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .yellow
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
        imageOfBrandImage.sizeToFit()
        
        nameOfBrandLabel.translatesAutoresizingMaskIntoConstraints = false
        nameOfBrandLabel.sizeToFit()
        nameOfBrandLabel.textColor = .black
        
    }
    
    func layout() {
        addSubview(imageOfBrandImage)
        addSubview(nameOfBrandLabel)
        
        NSLayoutConstraint.activate([
            imageOfBrandImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageOfBrandImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameOfBrandLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameOfBrandLabel.topAnchor.constraint(equalTo: imageOfBrandImage.bottomAnchor, constant: 5)
        
        ])
        
    }
    
    func configureCell(model: DataCarsModel){
        //imageOfBrandImage.image = UIImage(named: image ?? "default")
        nameOfBrandLabel.text = model.name
        
    }
    
}
