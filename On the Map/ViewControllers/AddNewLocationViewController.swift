//
//  AddNewLocationViewController.swift
//  On the Map
//
//  Created by Malik Basalamah on 24/03/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
import UIKit

class AddNewLocationViewController: UIViewController {
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
        linkTextField.delegate = self
    }
    
    @IBAction func findLocationAction(_ sender: Any) {
        guard !(locationTextField.text?.isEmpty)! else{
            return Client.sharedInstance().displayError("Fields must be filled", viewController: self, { (success) in
            })
        }
        performSegue(withIdentifier: "toPreviewLocation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Notice that this code works for both Scissors and Paper
        if segue.identifier == "toPreviewLocation"{
        let controller = segue.destination as! PreviewLocationViewController
            controller.location = locationTextField.text!
            controller.link = linkTextField.text!
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddNewLocationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
