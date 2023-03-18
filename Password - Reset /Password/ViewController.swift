//
//  ViewController.swift
//  Password
//
//  Created by Mahammad Afandiyev on 28.02.23.
//
import UIKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()
    let newPasswordTextField = PasswordTextField(placeHolderText: "New password")
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    let resetButton = UIButton(type: .system)
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        
    }
}

extension ViewController {
    func setup() {
        setupDismissKeyboardGesture()
        setupNewPassword()
        setupConfirmPassword()
        setupKeyboardHiding()
    }
    
    func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    func setupNewPassword() {
        let newPasswordValidation: CustomValidation = { text in
            
            
            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return (false, "Enter your Password")
            }
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.reset()
                return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
            }
            
            self.statusView.updateDisplay(text)
            if !self.statusView.validate(text) {
                return (false, "Your password must meet the requirements below")
            }
            
            return (true, "")
            
            
        }
        newPasswordTextField.customValidation = newPasswordValidation
    }
    func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = {text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password")
            }
            
            guard text == self.newPasswordTextField.text else {
                return(false, "Password do not match")
            }
            return (true , "")
            
        }
        confirmPasswordTextField.customValidation = confirmPasswordValidation
        confirmPasswordTextField.delegate = self
    }
    func setupDismissKeyboardGesture(){
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_ : )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped(_ recognizer : UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        newPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        newPasswordTextField.delegate = self
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        statusView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
        
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset Password", for: [])
        resetButton.addTarget(self, action: #selector(resetPasswordButtonPressed), for: .primaryActionTriggered)
        
    }
    
    func layout() {
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}

extension ViewController : PasswordTextFieldDelegate {
    func editingChanged(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
    func editingDidEnd(_ sender: PasswordTextField) {
        self.statusView.shouldResetCriteria = false
        if sender === newPasswordTextField {
            _ = newPasswordTextField.validate()
        } else if sender === confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
}
extension ViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
                     let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
                     let currentTextField = UIResponder.currentFirst() as? UITextField else { return }

        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldCondinatSystem = view.convert(currentTextField.frame, from: currentTextField.superview)
        let TextFieldBottomY = convertedTextFieldCondinatSystem.origin.y + convertedTextFieldCondinatSystem.size.height
        
        if TextFieldBottomY > keyboardTopY {
            let textYbody = convertedTextFieldCondinatSystem.origin.y
            let newFrameY = (textYbody - keyboardTopY/2) * -1
            view.frame.origin.y = newFrameY + 100
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

// MARK: Actions
extension ViewController {
    
    @objc func resetPasswordButtonPressed(sender: UIButton) {
        view.endEditing(true)
        
        let isValidNewPassword = newPasswordTextField.validate()
        let isValidConfirmPassword = confirmPasswordTextField.validate()
        
        if isValidNewPassword && isValidConfirmPassword {
            showAlert(title: "Success", message: "You have successfully changed your password.")
        } else {showAlert(title: "Failure", message: "Passwords not match")}
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.title = title
        alert.message = message
        present(alert, animated: true)
    }
    
}
