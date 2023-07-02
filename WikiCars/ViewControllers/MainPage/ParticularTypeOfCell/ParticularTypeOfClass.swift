//
//  ParticularTypeOfClass.swift
//  WikiCars
//
//  Created by m223 on 01.07.2023.
//

import UIKit

class ParticularTypeOfClass: UIViewController {
    
    var mainCollectionView: UICollectionView!
    
    let layoutFlow = UICollectionViewFlowLayout()
    
    var allModelInType: [DataCarsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setup()
        layout()
        network()
    }
    
    //MARK: - Two main function of configure view
    
    private func setup() {
        
        layoutFlow.scrollDirection = .vertical
        layoutFlow.minimumLineSpacing = 5
        layoutFlow.minimumInteritemSpacing = 1
        layoutFlow.itemSize = CGSize(width: (view.frame.size.width / 2) - 5, height: (view.frame.size.width / 2) - 5)
        
        mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mainCollectionView.backgroundColor = .lightGray
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(ParticularTypeOfClassCollectionViewCell.self, forCellWithReuseIdentifier: ParticularTypeOfClassCollectionViewCell.reuseID)
        
        
    }
    
    private func layout() {
        view.addSubview(mainCollectionView)
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

        ])
        
    }
    
    private func network() {
        
        APIManager.shared.getPosts(collection1: "DataOfCars", docName: title ?? "", collection2: "ParticularTypeOfCars") { allModels in
            self.allModelInType = allModels
            self.mainCollectionView.reloadData()
        }
        
    }
    
}

    //MARK: - Extensions

extension ParticularTypeOfClass: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CarInfoViewController()
        let selected = allModelInType[indexPath.row]
        vc.title = selected.name
        vc.brand = title
        navigationController?.pushViewController(vc, animated: false)
    }
    
}

extension ParticularTypeOfClass: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return allModelInType.count}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParticularTypeOfClassCollectionViewCell.reuseID, for: indexPath) as? ParticularTypeOfClassCollectionViewCell
        cell?.configureCell(model: allModelInType[indexPath.row])
        return cell!
        
    }
}
