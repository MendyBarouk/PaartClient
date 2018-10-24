//
//  SignUpViewController.swift
//  PaartClient
//
//  Created by Menahem Barouk on 24/10/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func createAccountButtonToucheUpInside(_ sender: Any) {
        
        ifNoError(validateCredential()) {
            guard let email = emailTextField.text,
                let password = passwordTextField.text else { return }
            
            register(withUsername: email, password: password)
        }
    }
    
    func validateCredential() -> Error? {
        guard let emailText = emailTextField.text,
            let passwordText = passwordTextField.text else { return nil }
        
        if emailText.isEmpty || passwordText.isEmpty {
            return PaartError.emptyField
        }
        
        if passwordText.count < 4 {
            return PaartError.passwordCount
        }
        
        if !emailText.isValideEmail {
            return PaartError.emailValidation
        }
        
        return nil
    }
    
    func register(withUsername username: String, password: String) {
        ZypeRestService.shared.register(withUsername: username, password: password) { (response) in
            
        }
    }
    
    func login(withUsername username: String, password: String) {
        
    }
}

extension SignUpViewController: URLSessionDelegate {
    
}

enum PaartError: Error {
    case emptyField
    case passwordCount
    case emailValidation
    case parseFailed(message:String)
}

extension PaartError: LocalizedError {
    var errorDescription: String? {
        let localizedDescription: String
        switch self {
        case .emptyField: localizedDescription = "Please fill out the missing fields and try again."
        case .passwordCount: localizedDescription = "Password must contain at least 4 characters "
        case .emailValidation: localizedDescription = "Please enter a valid email address and try again."
        case let .parseFailed(message): localizedDescription = message
        }
        return localizedDescription
    }
}

extension UIViewController {
    
    func ifNoError(_ error: Error?, _ execute: ()->()) {
        if let error = error {
            presentErrorAlert(error)
        } else {
            execute()
        }
    }
    
    func presentErrorAlert(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension String {
    var isValideEmail: Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", ".+@([a-zA-Z0-9\\-]+\\.)+[a-zA-Z0-9]{2,63}")
        return emailPredicate.evaluate(with: self)
    }
}
