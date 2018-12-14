//
//  LoginViewController.swift
//  On the Map
//
//  Created by Malik Basalamah on 22/03/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var debugLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    let signup = "https://www.udacity.com/account/auth#!/signup"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        setUIEnabled(true)
        
    }

    @IBAction func loginAction(_ sender: AnyObject) {
        guard !(usernameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! else{
            return Client.sharedInstance().displayError("Username or Password must be filled", viewController: self, { (success) in
                // do nothing
            })
        }
        setUIEnabled(false)
        authentication(username: usernameTextField.text!, password: passwordTextField.text!)
    }
    
    func authentication(username: String, password: String){
        Client.sharedInstance().getSessionID(username: username, password: password) { (success,errorString) in
            performUIUpdatesOnMain {
                if success {
                    self.completeLogin()
                } else {
                    self.setUIEnabled(true)
                    Client.sharedInstance().displayError(errorString, viewController: self, { (success) in
                        // do nothing
                    })
                }
            }
        }
    }
    
    @IBAction func signupAction(_ sender: Any) {
        if let url = URL(string: signup){
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func completeLogin(){
        debugLabel.text = "loading"
        Client.sharedInstance().toast("Login", "Successfully login ", viewController: self) { (success) in
            if success{
                let controller = self.storyboard!.instantiateViewController(withIdentifier: "FirstNavigationController") as! UINavigationController
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
}

// MARK: - LoginViewController: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {

// MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == usernameTextField {
            if !isValidateEmail(email: textField.text!){
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
            } else {
                textField.layer.borderWidth = 0.0
            }
        } else if textField == passwordTextField{
            if !isValidatePassword(name: textField.text!) {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
            } else {
                textField.layer.borderWidth = 0.0
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

// MARK: - LoginViewController (Configure UI)

private extension LoginViewController {
    
    func setUIEnabled(_ enabled: Bool) {
        loginButton.isEnabled = enabled
    }
    

    
    func isValidateEmail(email:String) -> Bool {
        return (email.contains("@")) && (email.contains("."))
    }
    
    func isValidatePassword(name:String) -> Bool {
        return name.count > 4
    }
}



