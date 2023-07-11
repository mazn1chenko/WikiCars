//
//  NewsPageCollectionViewCell.swift
//  WikiCars
//
//  Created by m223 on 11.07.2023.
//

import UIKit

class NewsPageCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "ParticularyID"
    
    var titleNewsLabel = UILabel()
    var descriptionOfNewsLabel = UILabel()
    var dateOfNewsLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        
        setup()
        layout()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        
        titleNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        titleNewsLabel.sizeToFit()
        titleNewsLabel.textColor = .black
        
        descriptionOfNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionOfNewsLabel.textColor = .black
        descriptionOfNewsLabel.numberOfLines = 0
        
        dateOfNewsLabel.translatesAutoresizingMaskIntoConstraints = false
        dateOfNewsLabel.sizeToFit()
        dateOfNewsLabel.textColor = .black
        
        
    }
    
    
    func layout() {
        addSubview(titleNewsLabel)
        addSubview(descriptionOfNewsLabel)
        addSubview(dateOfNewsLabel)
        
        NSLayoutConstraint.activate([
            titleNewsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleNewsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            
            descriptionOfNewsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionOfNewsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            descriptionOfNewsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            descriptionOfNewsLabel.heightAnchor.constraint(equalToConstant: frame.height / 1.6),
            
            dateOfNewsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            dateOfNewsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        
        ])
        
        
    }
    
    
    func configureCell(model: NewsModel){
        
        titleNewsLabel.text = model.title
        descriptionOfNewsLabel.text = model.description
        dateOfNewsLabel.text = model.date
        
        
    }
}
