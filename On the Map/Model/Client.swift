//
//  Client.swift
//  On the Map
//
//  Created by Malik Basalamah on 24/03/1440 AH.
//  Copyright © 1440 Malik Basalamah. All rights reserved.
//

import Foundation

class Client: NSObject{
    
    var session = URLSession.shared
    var sessionID : String? = nil
    var userID : String? = nil
    var userName: String? = nil
    var studentLocations: [[String:AnyObject]]? = nil
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    func taskForGETMethod(_ method: String, parameters: [String:AnyObject], type: String ,completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
    

        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: URLFromParameters(parameters: parameters, type: type, withPathExtension: method))

        if (type.contains(Constants.Request.PARSE)){
        request.addValue(Constants.AUTH.ApplicationID, forHTTPHeaderField: Constants.ParameterKeys.ApplicationID)
        request.addValue(Constants.AUTH.ApiKey, forHTTPHeaderField: Constants.ParameterKeys.ApiKey)
        }
        /* 4. Make the request */
        print(request.url!)
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            guard (type.contains(Constants.Request.UDACITY))
                else{
                    self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
                    return
            }
            
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForGET)
            
        }
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    // MARK: POST
    
    func taskForPOSTMethod(_ method: String,parameters: [String:AnyObject], type:String, jsonBody: String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {

        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: URLFromParameters(parameters: parameters, type: type,withPathExtension: method))
        
        request.httpMethod = "POST"

        if (type.contains(Constants.Request.UDACITY)){
            request.addValue(Constants.ParameterKeys.ApplicationJson, forHTTPHeaderField: Constants.ParameterKeys.Accept)
            
        }else if (type.contains(Constants.Request.PARSE)){
        request.addValue(Constants.AUTH.ApplicationID, forHTTPHeaderField: Constants.ParameterKeys.ApplicationID)
        request.addValue(Constants.AUTH.ApiKey, forHTTPHeaderField: Constants.ParameterKeys.ApiKey)
        }
        
        request.addValue(Constants.ParameterKeys.ApplicationJson, forHTTPHeaderField: Constants.ParameterKeys.ContentType)
        
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        print(jsonBody.data(using: String.Encoding.utf8)!)
        print(request.url!)
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            guard (type.contains(Constants.Request.UDACITY))
                else{
                    self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPOST)
                    return
            }
            
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPOST)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    func taskForPUTMethod(_ method: String,parameters: [String:AnyObject], type:String, jsonBody: String, completionHandlerForPUT: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: URLFromParameters(parameters: parameters, type: type,withPathExtension: method))
        request.httpMethod = "PUT"
        
        if (type.contains(Constants.Request.UDACITY)){
            request.addValue(Constants.ParameterKeys.ApplicationJson, forHTTPHeaderField: Constants.ParameterKeys.Accept)
            
        }else if (type.contains(Constants.Request.PARSE)){
            request.addValue(Constants.AUTH.ApplicationID, forHTTPHeaderField: Constants.ParameterKeys.ApplicationID)
            request.addValue(Constants.AUTH.ApiKey, forHTTPHeaderField: Constants.ParameterKeys.ApiKey)
        }
        
        request.addValue(Constants.ParameterKeys.ApplicationJson, forHTTPHeaderField: Constants.ParameterKeys.ContentType)
        
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        /* 4. Make the request */

        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPUT(nil, NSError(domain: "taskForPUTMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            guard (type.contains(Constants.Request.UDACITY))
                else{
                    self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForPUT)
                    return
            }
            
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPUT)
            
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    func taskForDeleteMethod(_ method: String,parameters: [String:AnyObject], type:String, completionHandlerForDelete: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: URLFromParameters(parameters: parameters, type: type,withPathExtension: method))
        
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        /* 4. Make the request */
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForDelete(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            guard (type.contains(Constants.Request.UDACITY))
                else{
                    self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForDelete)
                    return
            }
            
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForDelete)
            
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult, nil)
    }

    
    private func URLFromParameters(parameters: [String:AnyObject] ,type:String ,withPathExtension: String? = nil) -> URL {

        var URL_COMPONENTS = URLComponents()
        URL_COMPONENTS.scheme = Constants.BASE_UDACITY.ApiScheme
        
        if (type.contains(Constants.Request.UDACITY) ){
        URL_COMPONENTS.host = Constants.BASE_UDACITY.ApiHost
        URL_COMPONENTS.path = Constants.BASE_UDACITY.ApiPath + (withPathExtension ?? "")
        
        }else if(type.contains(Constants.Request.PARSE)){
        URL_COMPONENTS.host = Constants.BASE_PARSE.ApiHost
        URL_COMPONENTS.path = Constants.BASE_PARSE.ApiPath + (withPathExtension ?? "")
        }

        if parameters.count >= 1{
        URL_COMPONENTS.queryItems = [URLQueryItem]()
        
            for (key, value) in parameters {

                let queryItem = URLQueryItem(name: key, value: "\(value)")
                URL_COMPONENTS.queryItems!.append(queryItem)
            }
        }
        return URL_COMPONENTS.url!
    }
    
    
    // substitute the key for the value that is contained within the method name
    func substituteKeyInMethod(_ method: String, key: String, value: String) -> String? {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return nil
        }
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> Client {
        struct Singleton {
            static var sharedInstance = Client()
        }
        return Singleton.sharedInstance
    }
    
}
