//
//  PreviewLocationViewController.swift
//  On the Map
//
//  Created by Malik Basalamah on 29/03/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PreviewLocationViewController: UIViewController, MKMapViewDelegate{

    var location:String? = nil
    var link: String? = nil
    var placemark: CLPlacemark? = nil
    var data: [String:AnyObject]? = nil

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGeocodLocation(address: location!)
    }
    
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    
    func getGeocodLocation(address : String) {

        let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address, completionHandler: { (results, error) in
            if let error = error
            {
                Client.sharedInstance().displayError(error as? String, viewController: self) { (success) in
                    if success {
                        if let navigationController = self.navigationController{
                            navigationController.popToRootViewController(animated: true)
                    }
                }
                }
            }
            else if (results!.isEmpty)
            {
                Client.sharedInstance().displayError(error as? String, viewController: self) { (success) in
                    if success {
                        if let navigationController = self.navigationController{
                            navigationController.popToRootViewController(animated: true)
                        }
                    }
                }
            }
            else
            {
                self.placemark = results![0]
                self.mapView.showAnnotations([MKPlacemark(placemark: self.placemark!)], animated: true)
            }
            
        })
        
    }
    
    @IBAction func postLocationAction(_ sender: Any) {
        Client.sharedInstance().getPublicUserData(){ (success, results, errorString) in
            if success {
                performUIUpdatesOnMain {
                    let data:[String:AnyObject]
                        = [Constants.ParseResponseKeys.firstName : results?[Constants.UdacityResponseKeys.firstName] as AnyObject,
                           Constants.ParseResponseKeys.lastName : results?[Constants.UdacityResponseKeys.lastName] as AnyObject,
                           Constants.ParseResponseKeys.uniqueKey : results?[Constants.UdacityResponseKeys.uniqueKey] as AnyObject,
                              "mediaURL" : self.link as AnyObject,
                             "mapString" : self.location as AnyObject,
                            "longitude" : (self.placemark!.location?.coordinate.longitude)! as AnyObject,
                            "latitude" : (self.placemark!.location?.coordinate.latitude)! as AnyObject]

                    Client.sharedInstance().postStudentLocation(data, { (success, errorString) in
                        if success{
                            performUIUpdatesOnMain {
                                let controller = self.storyboard!.instantiateViewController(withIdentifier: "FirstNavigationController") as! UINavigationController
                                self.present(controller, animated: true, completion: nil)
                            }
                        }else{
                            Client.sharedInstance().displayError(errorString, viewController: self, { (success) in
                                // do nothing
                            })
                        }
                    })
                }
            }else{
                Client.sharedInstance().displayError(errorString, viewController: self, { (success) in
                    // do nothing
                })
            }
            
            
        }
    }
    
}
