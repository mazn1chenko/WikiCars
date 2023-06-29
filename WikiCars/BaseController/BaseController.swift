//
//  BaseController.swift
//  WikiCars
//
//  Created by m223 on 29.06.2023.
//

import UIKit

class BaseController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
}

@objc extension BaseController {
    
    func addViews() {}
    func configure() {
        
        view.backgroundColor = .lightGray
    }
}
