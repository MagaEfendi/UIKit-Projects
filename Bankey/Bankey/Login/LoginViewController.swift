//
//  ViewController.swift
//  Bankey
//
//  Created by Mahammad Afandiyev on 18.01.23.
//

import UIKit



protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {

    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    let brandMessage = UILabel()
    let bankey = UILabel()
    
    weak var delegate : LoginViewControllerDelegate?
    
    
    var username : String? {
        return loginView.usernameTextField.text
    }
    
    var password : String? {
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
}

extension LoginViewController {
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        
        brandMessage.translatesAutoresizingMaskIntoConstraints = false
        brandMessage.textAlignment = .center
        brandMessage.textColor = .black
        brandMessage.numberOfLines = 0
        brandMessage.text = "Your premium source for all things banking!"
        
        bankey.translatesAutoresizingMaskIntoConstraints = false
        bankey.textAlignment = .center
        bankey.textColor = .black
        bankey.text = "BANKEY"
        
        
        
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        view.addSubview(brandMessage)
        view.addSubview(bankey)
        
        //LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
        ])
        
        //Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
            
        ])
        
        //Error
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        //BrandMessage
        NSLayoutConstraint.activate([
            brandMessage.bottomAnchor.constraint(greaterThanOrEqualTo: loginView.topAnchor, constant:-25),
            brandMessage.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            brandMessage.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            
            bankey.bottomAnchor.constraint(equalToSystemSpacingBelow: brandMessage.topAnchor, multiplier:-40),
            bankey.leadingAnchor.constraint(equalTo: brandMessage.leadingAnchor),
            bankey.trailingAnchor.constraint(equalTo: brandMessage.trailingAnchor)
        ])
        
    }
}

// MARK: Actions
extension LoginViewController {
    @objc func signInTapped(sender : UIButton) {
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return 
        }
        
        if username == "Maga" && password == "160" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password")
            
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton()
    }
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0,10,-10,10,0]
        animation.keyTimes = [0,0.16,0.5,0.83,1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        signInButton.layer.add(animation,forKey: "shake")
    }
    
}

