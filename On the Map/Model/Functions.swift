//
//  Functions.swift
//  On the Map
//
//  Created by Malik Basalamah on 24/03/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation
import UIKit

extension Client {
    
    func authenticateWithViewController(_ hostViewController: UIViewController, completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        getSessionID() { (success, sessionID, userID, errorString) in
            if success {
                print(sessionID!)
                self.sessionID = sessionID
                self.userID = userID
                
               /* self.getPublicUserData(){ (success, userID, errorString) in
                    if success{
                        print(userID!)
                        self.userID = userID
                    } else{
                        completionHandlerForAuth(success, errorString)
                    }*/
                
            } else {
                completionHandlerForAuth(success, errorString)
            }
        }
    }
        
        private func getSessionID(completionHandlerForSession: @escaping (_ success: Bool, _ sessionID: String?,_ userID: Int?, _ errorString: String?) -> Void) {
                        
            /* 2. Make the request */
            let jsonBody = "{\"\(Constants.JSONBodyKeys.Udacity)\": {\"\(Constants.JSONBodyKeys.Username)\": \"\("user")\", \"\(Constants.JSONBodyKeys.Password)\": \"\("pass")\"}}"

            /* 2. Make the request */

            let _ = taskForPOSTMethod(Constants.Methods.Session, jsonBody: jsonBody) { (results, error) in
                
                /* 3. Send the desired value(s) to completion handler */
                if let error = error {
                    print(error)
                    completionHandlerForSession(false, nil, nil ,"Login Failed (Session ID).")
                } else {
                    if let sessionID = results?[Constants.JSONResponseKeys.SessionID] as? String , let userID = results?[Constants.JSONResponseKeys.UserID] as? Int {
                        completionHandlerForSession(true,sessionID,userID, nil)
                    } else {
                        if self.sessionID == nil{
                            print("Could not find \(Constants.JSONResponseKeys.SessionID) in \(results!)")
                        }else {
                            print("Could not find \(Constants.JSONResponseKeys.UserID) in \(results!)")
                        }
                    completionHandlerForSession(false, nil, nil ,"Login Failed (Session ID).")
                    }

                    }
                }
            }
        /*
        private func getPublicUserData(_ completionHandlerForUserID: @escaping (_ success: Bool, _ userID: Int?, _ errorString: String?) -> Void) {
            
            /* 2. Make the request */
            let _ = taskForGETMethod(Constants.Methods, parameters: parameters as [String:AnyObject]) { (results, error) in
                
                /* 3. Send the desired value(s) to completion handler */
                if let error = error {
                    print(error)
                    completionHandlerForUserID(false, nil, "Login Failed (User ID).")
                } else {
                    if let userID = results?[Constants.JSONResponseKeys.UserID] as? Int {
                        completionHandlerForUserID(true, userID, nil)
                    } else {
                        print("Could not find \(Constants.JSONResponseKeys.UserID) in \(results!)")
                        completionHandlerForUserID(false, nil, "Login Failed (User ID).")
                    }
                }
            }
        }*/
}
