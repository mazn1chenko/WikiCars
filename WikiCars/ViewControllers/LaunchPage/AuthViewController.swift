//
//  AuthViewController.swift
//  WikiCars
//
//  Created by m223 on 11.07.2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import Firebase

class AuthViewController: UIViewController {
    
    var registrLabel = UILabel()
    var nameTextField = UITextField()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var logInButton = UIButton(type: .system)
    
    var signUp: Bool = true {
        willSet{
            if newValue{
                
                registrLabel.text = "Реєстрація"
                nameTextField.isHidden = false
                
            }else{
                
                registrLabel.text = "Вход"
                nameTextField.isHidden = true
                
                
            }
        }
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        
        setup()
        layout()
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setup() {
        
        registrLabel.translatesAutoresizingMaskIntoConstraints = false
        registrLabel.textAlignment = .center
        registrLabel.text = "Реєстрація"
        registrLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        nameTextField.applyCommoStyle()
        nameTextField.placeholder = "Ваше імʼя"
        nameTextField.delegate = self
        nameTextField.returnKeyType = .continue
        
        emailTextField.applyCommoStyle()
        emailTextField.placeholder = "Ваш логін"
        emailTextField.delegate = self
        emailTextField.returnKeyType = .continue
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.applyCommoStyle()
        passwordTextField.placeholder = "Ваш пароль"
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .done

        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.setTitle("Вже маєте аккаунт?", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.backgroundColor = .orange
        logInButton.layer.cornerRadius = 10
        logInButton.addTarget(self, action: #selector(switchLogin(action:)), for: .touchUpInside)
        
        
    }
    
    private func layout() {
        view.addSubview(registrLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
        
        let heightOfAll: CGFloat = 35
        let widhtOfAll: CGFloat = view.frame.width / 1.5
        
        NSLayoutConstraint.activate([
            registrLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 5),
            registrLabel.widthAnchor.constraint(equalToConstant: widhtOfAll),
            registrLabel.heightAnchor.constraint(equalToConstant: heightOfAll),
            
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -10),
            nameTextField.heightAnchor.constraint(equalToConstant: heightOfAll),
            nameTextField.widthAnchor.constraint(equalToConstant: widhtOfAll),
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: heightOfAll),
            emailTextField.widthAnchor.constraint(equalToConstant: widhtOfAll),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            passwordTextField.heightAnchor.constraint(equalToConstant: heightOfAll),
            passwordTextField.widthAnchor.constraint(equalToConstant: widhtOfAll),

            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            logInButton.heightAnchor.constraint(equalToConstant: heightOfAll),
            logInButton.widthAnchor.constraint(equalToConstant: widhtOfAll / 1.2)
        ])
        
    }
    
    @objc func switchLogin(action: UIButton) {
        signUp = !signUp
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Помилка", message: "Введіть всі поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

extension UITextField: UITextFieldDelegate {
    
    func applyCommoStyle() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.textAlignment = .center
        self.backgroundColor = .white
        self.textColor = .gray
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "NoDate", attributes: attributes)
                
    }
}

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if(signUp) {
            if(!name.isEmpty && !email.isEmpty && !password.isEmpty){
                Auth.auth().createUser(withEmail: email, password: password){ result, error in
                    if error == nil{
                        if let result = result {
                            print(result.user.uid)
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name" : name, "email" : email])
                            self.dismiss(animated: true)
                        }
                    }
                }
                
            }else{
                showAlert()
            }
        }else{
            if(!email.isEmpty && !password.isEmpty){
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if error == nil {
                        
                        self.dismiss(animated: true)
                    }
                    
                }
                
            }else{
                showAlert()
            }
        }
        return true

    }
}
