//
//  ViewController.swift
//  Password
//
//  Created by Mahammad Afandiyev on 28.02.23.
//
import UIKit

class ViewController: UIViewController {
    
    let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
    let stackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
}

extension ViewController {
    
    func style() {
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
    }
    
    func layout() {
        stackView.addArrangedSubview(newPasswordTextField)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            newPasswordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: newPasswordTextField.trailingAnchor, multiplier: 1),
            newPasswordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
