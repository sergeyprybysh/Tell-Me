//
//  Client.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 6/8/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import Foundation

class Client: NSObject {

    var sharedSession: NSURLSession
    
    override init() {
        sharedSession = NSURLSession.sharedSession()
        super.init()
    }
    
    func taskForPOSTMethod(url: NSURL, authString: String, headers: [String: String], data: NSData, completionHandler handler: (data: NSData?, error: NSError?) -> Void) {
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue(authString, forHTTPHeaderField: "Authorization")
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        request.HTTPBody = data
        
        let task = sharedSession.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            guard error == nil else {
                print(error)
                handler(data: nil, error: error)
                return
            }
            
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                
                if let response = response as? NSHTTPURLResponse {
                    handler(data: nil, error: NSError(domain: "Networking", code: 001, userInfo: [NSLocalizedDescriptionKey: "Invalid response with status code \(response.statusCode)"]))
                }
                else if let _ = response {
                    handler(data: nil, error: NSError(domain: "Networking", code: 001, userInfo: [NSLocalizedDescriptionKey: "Invalid response"]))
                }
                else {
                    handler(data: nil, error: NSError(domain: "Networking", code: 001, userInfo: [NSLocalizedDescriptionKey: "Invalid response"]))
                }
                return
            }
            
            guard let data = data else {
                handler(data: nil, error: NSError(domain: "Networking", code: 002, userInfo: [NSLocalizedDescriptionKey: "No data was returned"]))
                return
            }
            
            handler(data: data, error: nil)
        }
        task.resume()
    }
    
    class func sharedInstance() -> Client {
        struct Singleton {
            static var sharedInstance = Client()
        }
        return Singleton.sharedInstance
    }
}

