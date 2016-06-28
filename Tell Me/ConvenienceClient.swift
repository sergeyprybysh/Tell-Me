//
//  ConvenienceClient.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 6/11/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import Foundation

extension Client {
    
    func getAudioTranscript(audioPath: NSURL, completionHandler handler: (data: [String : AnyObject]?, error: NSError?) -> Void)  {
    
        let components = NSURLComponents()
        
        components.scheme = IBMServiceConstants.scheme
        components.host = IBMServiceConstants.host
        components.path = IBMServiceConstants.path
        
        var headers = [String: String]()
        headers["Content-Type"] = "audio/wav"
        
        let data = NSData(contentsOfURL: audioPath)
        
        let authString = getBasicAuthCredentials()
        
        taskForPOSTMethod(components.URL!,authString: authString, headers: headers, data: data!) { (data, error) -> Void in
            guard error == nil else {
                print("Error is not nil " + error!.localizedDescription)
                handler(data: nil, error: error)
                return
            }
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            }
            catch {
                handler(data: nil, error: NSError(domain: "Serialization", code: 003, userInfo: [NSLocalizedDescriptionKey: "Unable deserialize data"]))
                return
            }
            print(parsedResult)
            guard let results = parsedResult[IBMResponseKeys.results] as? [[String: AnyObject]] else {
                handler(data: nil, error: NSError(domain: "Parsing", code: 003, userInfo: [NSLocalizedDescriptionKey: "Unable to parse JSON with key " + IBMResponseKeys.results]))
                return
            }
            
            guard let alternatives = results[0][IBMResponseKeys.alternatives] as? [[String: AnyObject]] else {
                handler(data: nil, error: NSError(domain: "Parsing", code: 003, userInfo: [NSLocalizedDescriptionKey: "Unable to parse JSON with key" + IBMResponseKeys.alternatives]))
                return
            }
            
            let recievedData = alternatives[0]
            handler(data: recievedData, error: nil)            
        }
    }
    
    
    func getBasicAuthCredentials() -> String {
        let username = IBMServiceConstants.username
        let password = IBMServiceConstants.password
        let userPasswordString = NSString(format: "%@:%@", username, password)
        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.init(rawValue: 0))
        return "Basic \(base64EncodedCredential)"
    }
    
}
