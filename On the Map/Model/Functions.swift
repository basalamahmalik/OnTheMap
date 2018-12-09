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

    func getSessionID(username: String ,password: String ,completionHandlerForSession: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
                        //let u = "basalamahmalik@gmail.com"
                        //let p = "malik44m"
            /* 2. Make the request */
            let jsonBody = "{\"\(Constants.JSONBodyKeys.Udacity)\": {\"\(Constants.JSONBodyKeys.Username)\": \"\(username)\", \"\(Constants.JSONBodyKeys.Password)\": \"\(password)\"}}"

            /* 2. Make the request */

            let _ = taskForPOSTMethod(Constants.Methods.Session, parameters: [:],type: Constants.Request.UDACITY, jsonBody: jsonBody) { (results, error) in
                /* 3. Send the desired value(s) to completion handler */
                guard (error == nil) else{
                    print(error!)
                    if ((error?.isEqual("There was an error with your request: \(error!)"))!){
                    completionHandlerForSession(false, "Login Failed (Please Check Your Network).")
                    }else{
                completionHandlerForSession(false,"Login Failed (Incorrect Email or Password, Please try again).")

                    }
                    return
                }
                
                guard let parsedData = results?[Constants.JSONResponseKeys.Session] as? [String:AnyObject],
                    let sessionID = parsedData[Constants.JSONResponseKeys.SessionID] as? String
                     else {
                        print("Could not find \(Constants.JSONResponseKeys.SessionID) in \(results!)")
                        completionHandlerForSession(false,"Login Failed (Session ID).")
                        return
                         }

                guard let account = results?[Constants.JSONResponseKeys.Account] as? [String:AnyObject],
                    let userID = account[Constants.JSONResponseKeys.UserID] as? String
                    else {
                print("Could not find \(Constants.JSONResponseKeys.UserID) in \(results!)")
                completionHandlerForSession(false,"Login Failed (Session ID).")
                return
                }
                self.sessionID = sessionID
                self.userID = userID
                completionHandlerForSession(true,nil)
            }
    }
    
    
    func getPublicUserData(_ completionHandlerForUserData: @escaping (_ success: Bool, _ results: [String:AnyObject]?, _ errorString: String?) -> Void) {
            
            /* 2. Make the request */
            var method: String = Constants.Methods.Account
        method = substituteKeyInMethod(method, key: Constants.URLKeys.UserID, value: Client.sharedInstance().userID!)!
            
        let _ = taskForGETMethod(method, parameters: [:],type: Constants.Request.UDACITY) { (results, error) in
                
                /* 3. Send the desired value(s) to completion handler */
                guard (error == nil) else{
                    print(error!)
                    completionHandlerForUserData(false, nil ,"Login Failed (Session ID).")
                    return
                }
//                guard let userName = results?[Constants.JSONResponseKeys.UserName] as? String
//                else{
//                    print("error")
//                    completionHandlerForUserData(false, nil ,"Login Failed (Session ID).")
//                    return
//                }
            completionHandlerForUserData(true, (results as! [String : AnyObject]) ,nil)
            }
        }
    
    func getStudentsLocation(_ completionHandlerForStudentsLocation: @escaping (_ success: Bool, _ results: [StudentInformation]?, _ errorString: String?) -> Void) {
        //if you want specifec order
        let params = [Constants.ParameterKeys.Order: "-updatedAt" as AnyObject]
        /* 2. Make the request */
        let method: String = Constants.Methods.StudentLocation
        
        let _ = taskForGETMethod(method ,parameters: params ,type: Constants.Request.PARSE) { (results, error) in
            /* 3. Send the desired value(s) to completion handler */
            guard (error == nil) else{
                print(error!)
                completionHandlerForStudentsLocation(false, nil ,"Getting Students Location Failed.")
                return
            }
            guard let data = results?["results"] as? [[String:AnyObject]] else{
            completionHandlerForStudentsLocation(false, nil ,"Getting Students Location Failed.")
            return
            }
            let studentInformations = StudentInformation.LocationsFromResults(data)
            //print(studentInformations)
            completionHandlerForStudentsLocation(true, studentInformations ,nil)
        }
    }
    
    func getStudentLocation(_ completionHandlerForStudentLocation: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let quary = substituteKeyInMethod(Constants.Methods.SingleStudent, key: Constants.URLKeys.UniqueKey, value: "1234")
        let parameters = [Constants.ParameterKeys.SingleStudent:quary]
        /* 2. Make the request */
        let method: String = "\(Constants.Methods.StudentLocation)"

        let _ = taskForGETMethod(method, parameters: parameters as [String : AnyObject],type: Constants.Request.PARSE) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            guard (error == nil) else{
                print(error!)
                completionHandlerForStudentLocation(false ,"Login Failed (Session ID).")
                return
            }
            completionHandlerForStudentLocation(true ,nil)
        }
    }
    
    
    func postStudentLocation(_ studentInfo: [String:AnyObject],_ completionHandlerForPostStudentLocation: @escaping (_ success: Bool,_ errorString: String?) -> Void) {

        let firstname = studentInfo[Constants.ParseResponseKeys.firstName]
        let lastname = studentInfo[Constants.ParseResponseKeys.lastName]
        let uniqueKey = studentInfo[Constants.ParseResponseKeys.uniqueKey]
        let mapString = studentInfo[Constants.ParseResponseKeys.mapString]
        let mediaURL = studentInfo[Constants.ParseResponseKeys.mediaURL]
        let longitude = studentInfo[Constants.ParseResponseKeys.longitude]
        let latitude = studentInfo[Constants.ParseResponseKeys.latitude]



        /* 2. Make the request */
        let method: String = "\(Constants.Methods.StudentLocation)"

        let jsonBody = "{\"\(Constants.ParseResponseKeys.uniqueKey)\": \"\(uniqueKey!)\", \"\(Constants.ParseResponseKeys.firstName)\": \"\(firstname!)\", \"\(Constants.ParseResponseKeys.lastName)\": \"\(lastname!)\",\"\(Constants.ParseResponseKeys.mapString)\": \"\(mapString!)\", \"\(Constants.ParseResponseKeys.mediaURL)\": \"\(mediaURL!)\",\"\(Constants.ParseResponseKeys.latitude)\": \(latitude!), \"\(Constants.ParseResponseKeys.longitude)\": \(longitude!)}"
        

        print(jsonBody)
        /* 2. Make the request */
        
        let _ = taskForPOSTMethod(method, parameters: [:],type: Constants.Request.PARSE, jsonBody: jsonBody) { (results, error) in
            /* 3. Send the desired value(s) to completion handler */
            guard (error == nil) else{
                print(error!)
                completionHandlerForPostStudentLocation(false,"Post Failed.")
                return
            }
            completionHandlerForPostStudentLocation(true,nil)
        }
    }
    
    func UpdateStudentLocation(_ completionHandlerForPostStudentLocation: @escaping (_ success: Bool,_ errorString: String?) -> Void) {
        
        /* 2. Make the request */
        let quary = substituteKeyInMethod(Constants.Methods.UpdateStudent, key: Constants.URLKeys.OpjectID, value: "UNqnLeCsnB")

        let jsonBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Cupertino, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.322998, \"longitude\": -122.032182}"
        
        /* 2. Make the request */
        let method: String = "\(Constants.Methods.StudentLocation)\(quary!)"

        let _ = taskForPUTMethod(method, parameters: [:],type: Constants.Request.PARSE, jsonBody: jsonBody) { (results, error) in
            /* 3. Send the desired value(s) to completion handler */
            guard (error == nil) else{
                print(error!)
                completionHandlerForPostStudentLocation(false,"Update Failed.")
                return
            }
            completionHandlerForPostStudentLocation(true,nil)
        }
    }

    func logoutSession(_ completionHandlerForLogout: @escaping (_ success: Bool,_ errorString: String?) -> Void) {
    
        /* 2. Make the request */
        let method: String = "\(Constants.Methods.Session)"
        
        let _ = taskForDeleteMethod(method, parameters: [:],type: Constants.Request.UDACITY) { (results, error) in
            /* 3. Send the desired value(s) to completion handler */
            guard (error == nil) else{
                print(error!)
                completionHandlerForLogout(false,"Logout Failed.")
                return
            }
            completionHandlerForLogout(true,nil)
        }
    }
    
    
    func displayError(_ errorString: String?, viewController:UIViewController,_ completionHandlerForAlert: @escaping (_ success: Bool) -> Void) {
        
        if let errorString = errorString {
            
            let alertController = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: .default)
            // Add the actions
            alertController.addAction(okAction)
            // Present the controller
            viewController.present(alertController, animated: true, completion: nil)
            completionHandlerForAlert(true)
        }
        
    }
    
    func logout(viewController: UIViewController) {
        Client.sharedInstance().logoutSession { (success, errorString) in
            if success {
                performUIUpdatesOnMain {
                    let loginVC : LoginViewController = viewController.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    viewController.present(loginVC,animated: true, completion: nil)
                }
            }else{
                Client.sharedInstance().displayError(errorString, viewController: viewController, { (success) in
                    // do nothing
                })
            }
        }
    }

    func toast(_ title:String?, _ message: String?, viewController:UIViewController,_ completionHandlerForAlert: @escaping (_ success: Bool) -> Void) {
        // this code has been taking from the internet
        // https://stackoverflow.com/questions/44733565/how-to-create-toast-notification-with-diff-diff-msg-in-swift-3
        
        let messageVC = UIAlertController(title: title, message: message , preferredStyle: .actionSheet)
        viewController.present(messageVC, animated: true) {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (_) in
                messageVC.dismiss(animated: true, completion: {
                    completionHandlerForAlert(true)
                })
            }
            )
        }
    }
    
}


