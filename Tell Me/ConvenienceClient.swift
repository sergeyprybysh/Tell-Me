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
        
        components.scheme = IBMSpeechToText.scheme
        components.host = IBMSpeechToText.host
        components.path = IBMSpeechToText.path
        
        var headers = [String: String]()
        headers[Headers.content_type] = "audio/wav"
        
        let data = NSData(contentsOfURL: audioPath)
        
        let authString = getBasicAuthCredentialsFor(.SpeechToText)
        
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
                handler(data: nil, error: NSError(domain: "Serialization", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unable deserialize data"]))
                return
            }
            
            //TODO: remove it.
            print(parsedResult)
            guard let results = parsedResult[IBMResponseKeys.results] as? [[String: AnyObject]] else {
                handler(data: nil, error: NSError(domain: "Parsing", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unable to parse JSON with key: " + IBMResponseKeys.results]))
                return
            }
            //TODO: fix no resuls.
            guard let alternatives = results[0][IBMResponseKeys.alternatives] as? [[String: AnyObject]] else {
                handler(data: nil, error: NSError(domain: "Parsing", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unable to parse JSON with key: " + IBMResponseKeys.alternatives]))
                return
            }
            
            let recievedData = alternatives[0]
            handler(data: recievedData, error: nil)
            
        }
    }
    
    
    func analyzeText(text: String, completionHandler handler: (emotionTone: [EmotionsTone.Emotions : Double]?, languageTone: [LanguageTone.Language : Double]?, socialTone: [SocialTone.Social : Double]?, error: NSError?) -> Void) {
            
        let comp = NSURLComponents()
            
        comp.scheme = IBMToneAnalizer.scheme
        comp.host = IBMToneAnalizer.toneAnalyzerHost
        comp.path = IBMToneAnalizer.toneAnalyzerPath
        comp.percentEncodedQuery = IBMToneAnalizer.toneAnalyzerQuery
            
        var headers = [String: String]()
        headers[Headers.content_type] = Client.Headers.contentTypeText
            
        let data = text.dataUsingEncoding(NSUTF8StringEncoding)
        
        let authString = getBasicAuthCredentialsFor(.ToneAnalyzer)
        print(comp)
        
        taskForPOSTMethod(comp.URL!, authString: authString, headers: headers, data: data!) { (data, error) -> Void in
            
            guard error == nil else {
                print("Error is not nil " + error!.localizedDescription)
                handler(emotionTone: nil, languageTone: nil, socialTone: nil, error: error)
                return
            }
            
            let parsedData = self.parseToneAnalyzerResponse(data!)
            
            guard parsedData.error == nil else {
                print("Error is not nil " + parsedData.error!.localizedDescription)
                handler(emotionTone: nil, languageTone: nil, socialTone: nil, error: error)
                return
            }
            let emotionT = parsedData.emotionTone!
            let languageT = parsedData.languageTone!
            let socialT =  parsedData.socialTone!
            
            handler(emotionTone: emotionT, languageTone: languageT, socialTone: socialT, error: nil)
        }
    }
    
    
    private func getBasicAuthCredentialsFor(service: Service) -> String {
        
        var username: String!
        var password: String!
        
        switch service {
            
        case .SpeechToText:
            username = IBMSpeechToText.username
            password = IBMSpeechToText.password
            break
            
        case .ToneAnalyzer:
            username = IBMToneAnalizer.username
            password = IBMToneAnalizer.password
            break
        }
        
        let userPasswordString = NSString(format: "%@:%@", username, password)
        let userPasswordData = userPasswordString.dataUsingEncoding(NSUTF8StringEncoding)
        let base64EncodedCredential = userPasswordData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.init(rawValue: 0))
        return "Basic \(base64EncodedCredential)"
    }
    
    enum Service {
        case ToneAnalyzer, SpeechToText
    }
    
}
