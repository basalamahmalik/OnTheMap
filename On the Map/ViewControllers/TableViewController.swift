//
//  TableViewController.swift
//  On the Map
//
//  Created by Malik Basalamah on 22/03/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    var studentInformations = Client.sharedInstance().studentInformations


    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        loadData()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        Client.sharedInstance().logout(viewController: self)
        }
    
    func loadData(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        Client.sharedInstance().getStudentsLocation { (success, results, errorString) in
            // We will create an MKPointAnnotation for each dictionary in "locations". The
            // point annotations will be stored in this array, and then provided to the map view.
            if success{
                performUIUpdatesOnMain {
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.studentInformations = results!
                    self.tableView.reloadData()
                }
            }else{
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                Client.sharedInstance().displayError(errorString, viewController: self, { (success) in

                })
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentInformations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) 
        let data = studentInformations[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = "\(data.firstName) \(data.lastName)"
        cell.detailTextLabel?.text = "\(data.mediaURL)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = studentInformations[(indexPath as NSIndexPath).row]
        if let url = URL(string: data.mediaURL){
            if UIApplication.shared.canOpenURL(URL(string: data.mediaURL)!){
                UIApplication.shared.open(url, options: [:])
            }
    }
    }
}


