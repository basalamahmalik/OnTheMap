//
//  Data.swift
//  On the Map
//
//  Created by Malik Basalamah on 24/03/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation


struct StudentLocation {
    
    var objectID: String
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
    
    init(_ locationDictionary: [String:AnyObject])
    {
        // Check & Set the most important properties
        firstName = locationDictionary[Constants.ParseResponseKeys.firstName] as! String
        lastName = locationDictionary[Constants.ParseResponseKeys.lastName] as! String
        latitude = locationDictionary[Constants.ParseResponseKeys.latitude] as! Double
        longitude = locationDictionary[Constants.ParseResponseKeys.longitude] as! Double
        mediaURL = locationDictionary[Constants.ParseResponseKeys.mediaURL] as! String
        objectID = locationDictionary[Constants.ParseResponseKeys.objectID] as! String
    }
}
