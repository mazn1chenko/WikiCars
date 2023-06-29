//
//  MainPageViewController.swift
//  WikiCars
//
//  Created by m223 on 29.06.2023.
//

import UIKit

class MainPageViewController: BaseController {
    
    var mainCollectionView: UICollectionView!
    
    let layoutFlow = UICollectionViewFlowLayout()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "WikiCars"
        
        navigationController?.navigationBar.isTranslucent = true

        setup()
        layout()
    }
    
    //MARK: - Two main function of configure view
    
    private func setup() {
        
        layoutFlow.scrollDirection = .vertical
        layoutFlow.minimumLineSpacing = 5
        layoutFlow.minimumInteritemSpacing = 1
        layoutFlow.itemSize = CGSize(width: (view.frame.size.width / 2) - 5, height: (view.frame.size.width / 2) - 5)
        
        mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
        mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mainCollectionView.backgroundColor = .white
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(MainPageCollectionViewCell.self, forCellWithReuseIdentifier: MainPageCollectionViewCell.reuseID)
        
        
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

}

extension MainPageViewController: UICollectionViewDelegate{
    
    
}

extension MainPageViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 15 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageCollectionViewCell.reuseID, for: indexPath) as? MainPageCollectionViewCell
        cell?.configureCell(image: "default", nameOfBrand: "audi")
        return cell!
    }
    
    
    
}

