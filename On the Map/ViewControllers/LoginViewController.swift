//
//  LoginViewController.swift
//  On the Map
//
//  Created by Malik Basalamah on 22/03/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usarnameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var debugLabel: UILabel!
    
    var session: URLSession!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }

    @IBAction func loginAction(_ sender: Any) {
        Client.sharedInstance().authenticateWithViewController(self) { (success, errorString) in
            performUIUpdatesOnMain {
                if success {
                    self.completeLogin()
                } else {
                    self.displayError(errorString)
                }
            }
        }
        
    }
    func completeLogin(){
        debugLabel.text = ""
        let controller = storyboard!.instantiateViewController(withIdentifier: "FirstNavigationController") as! UINavigationController
        present(controller, animated: true, completion: nil)
    }
    
    func displayError(_ errorString: String?) {
        if let errorString = errorString {
            debugLabel.text = errorString
        }
    }
    
}

// MARK: - LoginViewController: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {

// MARK: UITextFieldDelegate

}

// MARK: - LoginViewController (Configure UI)

private extension LoginViewController {

}

// MARK: - LoginViewController (Notifications)

private extension LoginViewController {

}

