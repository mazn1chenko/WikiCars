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
            
        var allNewsArray: [NewsModel] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            title = "Новини"
            
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
            layoutFlow.itemSize = CGSize(width: (view.frame.size.width / 1.03),
                                         height: view.frame.size.height / 3)
            
            mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
            mainCollectionView.translatesAutoresizingMaskIntoConstraints = false
            mainCollectionView.backgroundColor = .lightGray
            mainCollectionView.delegate = self
            mainCollectionView.dataSource = self
            mainCollectionView.register(NewsPageCollectionViewCell.self, forCellWithReuseIdentifier: NewsPageCollectionViewCell.reuseID)
            
            
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
                
                self.allNewsArray = all
                self.mainCollectionView.reloadData()
                
            }
        }
        
    }

        //MARK: - Extensions

    extension NewsPageViewController: UICollectionViewDelegate {
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = CarInfoViewController()
            let selected = allNewsArray[indexPath.row]
            vc.title = selected.title
            vc.brand = title
            navigationController?.pushViewController(vc, animated: false)
        }
        
    }

    extension NewsPageViewController: UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return allNewsArray.count}
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsPageCollectionViewCell.reuseID, for: indexPath) as? NewsPageCollectionViewCell
            cell?.configureCell(model: allNewsArray[indexPath.row])
            cell!.layer.cornerRadius = 10
            return cell!
            
        }
    }


