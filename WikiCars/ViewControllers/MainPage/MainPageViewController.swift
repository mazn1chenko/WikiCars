//
//  MainPageViewController.swift
//  WikiCars
//
//  Created by m223 on 29.06.2023.
//
import UIKit

class MainPageViewController: BaseController {
    
    var mainTableView: UITableView!
    
    var allBrandsOfCars: [String]?
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "WikiCars"
        
        setup()
        layout()
        network()
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        mainTableView.refreshControl = refreshControl
    }
    
    //MARK: - Two main function of configure view
    
    private func setup() {
        mainTableView = UITableView()
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.backgroundColor = .lightGray
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainPageTableViewCell.self, forCellReuseIdentifier: MainPageTableViewCell.reuseID)
        mainTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    }
    
    private func layout() {
        view.addSubview(mainTableView)
        
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    //MARK: - Network
    
    private func network(){
        APIManager.shared.gettingCarsOfAllBrands(collection: "DataOfCars", docName: "AllBrands") { all in
            self.allBrandsOfCars = all
            self.mainTableView.reloadData()
        }
    }
    
    @objc private func refreshData() {
        mainTableView.reloadData()
        refreshControl.endRefreshing()
    }
}

//MARK: - Extensions

extension MainPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ParticularTypeOfClass()
        vc.title = allBrandsOfCars?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 120 }
    
}

extension MainPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBrandsOfCars?.count ?? 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainPageTableViewCell.reuseID, for: indexPath) as? MainPageTableViewCell
        cell?.configureCell(nameOfBrand: allBrandsOfCars?[indexPath.row] ?? "NoInternet")
        return cell!
    }
}

