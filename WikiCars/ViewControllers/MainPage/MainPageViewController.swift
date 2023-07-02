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
    
    var allBrandsOfCars: [String]?
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "WikiCars"
        
        setup()
        layout()
        network()
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        mainCollectionView.refreshControl = refreshControl
        
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
    
    //MARK: - Network
    
    func network(){
        
        APIManager.shared.gettingCarsOfAllBrands(collection: "DataOfCars", docName: "AllBrands") { all in
            self.allBrandsOfCars = all
            self.mainCollectionView.reloadData()
            
        }
        
        
    }
    
    @objc private func refreshData() {
        mainCollectionView.reloadData()
        
        refreshControl.endRefreshing()
    }
}

    //MARK: - Extensions

extension MainPageViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ParticularTypeOfClass()
        vc.title = allBrandsOfCars?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension MainPageViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return allBrandsOfCars?.count ?? 1 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageCollectionViewCell.reuseID, for: indexPath) as? MainPageCollectionViewCell
        cell?.configureCell(nameOfBrand: allBrandsOfCars?[indexPath.row] ?? "NoInternet")
        return cell!
    }
    
    
    
}

