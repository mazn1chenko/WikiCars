//
//  NewsPageViewController.swift
//  WikiCars
//
//  Created by m223 on 29.06.2023.
//

import UIKit

class NewsPageViewController: BaseController {
        
        var mainCollectionView: UICollectionView!
        
        let layoutFlow = UICollectionViewFlowLayout()
        
        var allModelInType: [DataCarsModel] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            setup()
            layout()
            network()
            view.backgroundColor = .lightGray
            
            
        }
        
        //MARK: - Two main function of configure view
        
        private func setup() {
            
            layoutFlow.scrollDirection = .vertical
            layoutFlow.minimumLineSpacing = 5
            layoutFlow.minimumInteritemSpacing = 1
            layoutFlow.itemSize = CGSize(width: (view.frame.size.width / 2.1), height: (view.frame.size.width / 2.1))
            
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
                mainCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
                mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                mainCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),

            ])
            
        }
        
        private func network() {
            
            APIManager.shared.getNews(collection: "NewsOfCar") { all in
                //print(all)
            }
        }
        
    }

        //MARK: - Extensions

    extension NewsPageViewController: UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = CarInfoViewController()
            let selected = allModelInType[indexPath.row]
            vc.title = selected.name
            vc.brand = title
            navigationController?.pushViewController(vc, animated: false)
        }
        
    }

    extension NewsPageViewController: UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return allModelInType.count}
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ParticularTypeOfClassCollectionViewCell.reuseID, for: indexPath) as? ParticularTypeOfClassCollectionViewCell
            cell?.configureCell(model: allModelInType[indexPath.row])
            return cell!
            
        }
    }


