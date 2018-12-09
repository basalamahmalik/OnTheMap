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

    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    var studentInformations = [StudentInformation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        self.loadData()
        Client.sharedInstance().toast("Refreash", "Data have been Refreshed", viewController: self) { (success) in
            if success{
            }
        }
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        Client.sharedInstance().logout(viewController: self)
        }
    
    func loadData(){
        Client.sharedInstance().getStudentsLocation { (success, results, errorString) in
            // We will create an MKPointAnnotation for each dictionary in "locations". The
            // point annotations will be stored in this array, and then provided to the map view.
            if success{
                performUIUpdatesOnMain {
                    self.studentInformations = results!
                    self.tableView.reloadData()
                }
            }else{
                Client.sharedInstance().displayError(errorString, viewController: self, { (success) in
                    // do nothing
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


