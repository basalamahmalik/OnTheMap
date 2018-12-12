//
//  MapViewController.swift
//  On the Map
//
//  Created by Malik Basalamah on 22/03/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var studentInformations = Client.sharedInstance().studentInformations

    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        self.loadData()
    }
    
    func loadData(){

        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    
        Client.sharedInstance().getStudentsLocation { (success, results, errorString) in
            // We will create an MKPointAnnotation for each dictionary in "locations". The
            // point annotations will be stored in this array, and then provided to the map view.
            var annotations = [MKPointAnnotation]()
            if success{
                    self.studentInformations = results!
                
                for dictionary in self.studentInformations {
                    
                    // Notice that the float values are being used to create CLLocationDegree values.
                    // This is a version of the Double type.
                    let lat = CLLocationDegrees(dictionary.latitude)
                    let long = CLLocationDegrees(dictionary.longitude)
                    
                    // The lat and long are used to create a CLLocationCoordinates2D instance.
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    
                    let first = dictionary.firstName
                    let last = dictionary.lastName
                    let mediaURL = dictionary.mediaURL
                    
                    // Here we create the annotation and set its coordiate, title, and subtitle properties
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = "\(first) \(last)"
                    annotation.subtitle = mediaURL
                   
                    annotations.append(annotation)
                }
                performUIUpdatesOnMain {
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.mapView.addAnnotations(annotations)
                }
            }else{
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                Client.sharedInstance().displayError(errorString, viewController: self, { (success) in

                })
            }
        }

    }
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle!{
                if app.canOpenURL(URL(string: toOpen)!){
                    app.open(URL(string: toOpen)!, options: [:])
                }
                    }
            }
        }
    
    @IBAction func refreshAction(_ sender: Any) {
        loadData()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        Client.sharedInstance().logout(viewController: self)
    }
    

}
