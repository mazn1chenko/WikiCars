//
//  SettingsPageViewController.swift
//  WikiCars
//
//  Created by m223 on 29.06.2023.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore

class SettingsPageViewController: BaseController {
    
    var exitButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Налаштування"
        
        navigationController?.navigationBar.isTranslucent = true

        
        setup()
        layout()
    }
    
    //MARK: - Two main function of configure view
    
    private func setup() {
        
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.setTitle("Вихід з аккаунту", for: .normal)
        exitButton.setTitleColor(.black, for: .normal)
        exitButton.addTarget(self, action: #selector(exitFromAcc(action:)), for: .touchUpInside)
        exitButton.sizeToFit()
        
    }
    
    private func layout() {
        view.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exitButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    @objc func exitFromAcc(action: UIButton) {
        
        do {
            try Auth.auth().signOut()
        }catch{
            print(error)
        }
        
    }

}
