//
//  NavigationBarController.swift
//  WikiCars
//
//  Created by m223 on 29.06.2023.
//

import UIKit

final class NavigationBarController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        
        view.backgroundColor = .yellow
        navigationController?.navigationBar.isTranslucent = false
        

        
    }

}
