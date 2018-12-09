//
//  Data.swift
//  On the Map
//
//  Created by Malik Basalamah on 24/03/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation


struct StudentInformation {
    
    let objectID: String
    let uniqueKey: String?
    let firstName: String
    let lastName: String
    let mapString: String?
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    
    init(locationDictionary: [String:AnyObject])
    {
        // Check & Set the most important properties
        firstName = locationDictionary[Constants.ParseResponseKeys.firstName] as! String
        lastName = locationDictionary[Constants.ParseResponseKeys.lastName] as! String
        latitude = locationDictionary[Constants.ParseResponseKeys.latitude] as! Double
        //longitude = locationDictionary[Constants.ParseResponseKeys.longitude] as! Double
        mediaURL = locationDictionary[Constants.ParseResponseKeys.mediaURL] as! String
        //objectID = locationDictionary[Constants.ParseResponseKeys.objectID] as! String
        if let longitude = locationDictionary[Constants.ParseResponseKeys.longitude] as? Double {
            self.longitude = longitude
        } else {
            self.longitude = 0.0
        }
        
        if let objectID = locationDictionary[Constants.ParseResponseKeys.objectID] as? String {
            self.objectID = objectID
        } else {
            self.objectID = ""
        }
        
        if let uniqueKey = locationDictionary[Constants.ParseResponseKeys.uniqueKey] as? String {
            self.uniqueKey = uniqueKey
        } else {
            self.uniqueKey = ""
        }
        
        if let mapString = locationDictionary[Constants.ParseResponseKeys.mapString] as? String {
            self.mapString = mapString
        } else {
            self.mapString = ""
        }


    }
    
    static func LocationsFromResults(_ results: [[String:AnyObject]]) -> [StudentInformation] {
        
        var location = [StudentInformation]()
        
        // iterate through array of dictionaries, each Movie is a dictionary
        for result in results {
            location.append(StudentInformation(locationDictionary: result))
        }
        
        return location
    }
}
