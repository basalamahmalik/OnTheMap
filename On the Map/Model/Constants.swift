//
//  Constants.swift
//  On the Map
//
//  Created by Malik Basalamah on 24/03/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct AUTH {
        static let ApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    }
    
    struct BASE_UDACITY {
        static let ApiScheme = "https"
        static let ApiHost = "onthemap-api.udacity.com"
        static let ApiPath = "/v1"
    }

    struct BASE_PARSE{
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse/classes"
    }
    
    struct Methods {
        // MARK:
        static let Session = "/session"
        static let Account = "/users/{user_id}"
        static let StudentLocation = "/StudentLocation"
        static let SingleStudent = "{\"uniqueKey\":\"\("{value}")\"}"
        static let UpdateStudent = "/{objectId}"
    }
    struct Request {
        static let UDACITY = "UDACITY"
        static let PARSE   = "PARSE"
    }
    // MARK: URL Keys
    struct URLKeys {
        static let UserID = "user_id"
        static let UniqueKey="value"
        static let OpjectID = "objectId"
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let ApiKey = "X-Parse-REST-API-Key"
        static let ApplicationID = "X-Parse-Application-Id"
        static let Accept = "Accept"
        static let ApplicationJson = "application/json"
        static let ContentType = "Content-Type"
        static let SessionID = "session"
        static let UserID = "user_id"
        static let SingleStudent = "where" 
        static let UniqeKey   = "uniqueKey"
        static let Order = "order"
    }
    
    struct JSONBodyKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    struct JSONResponseKeys {
        
        // MARK: Authorization
        static let Session = "session"
        static let SessionID = "id"
        // MARK: Account
        static let Account = "account"
        static let UserID = "key"
        // MARK: User Public Data
        static let User = "user"
    }
    
    struct ParseResponseKeys {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let createdAt = "createdAt"
        static let updatedAt = "updatedAt"
        static let results = "results"
        static let objectID = "objectId"
        static let uniqueKey = "uniqueKey"
        static let mapString = "mapString"
        static let mediaURL = "mediaURL"
    }
    struct UdacityResponseKeys {
        static let firstName = "first_name"
        static let lastName  = "last_name"
        static let uniqueKey = "key"
    }
}
