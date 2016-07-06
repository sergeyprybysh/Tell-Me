//
//  ParsersClient.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 7/4/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import Foundation

extension Client {
    
    func parseToneAnalyzerResponse(data: NSData) -> (emotionTone: [EmotionsTone.Emotions : Double]?, languageTone: [LanguageTone.Language : Double]?, socialTone: [SocialTone.Social : Double]?, error: NSError?) {
        
        var emotionT: [EmotionsTone.Emotions : Double]?
        var languageT: [LanguageTone.Language : Double]?
        var socialT: [SocialTone.Social : Double]?
        
        let parsedResult: AnyObject!
        do {
            parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        }
        catch {
            return (emotionTone: nil, languageTone: nil, socialTone: nil, error: NSError(domain: "Serialization", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unable deserialize data"]))
        }
        print(parsedResult)
        
        guard let documentTone = parsedResult[IBMResponceKeysToneAnalyzer.documentTone] as? [String: AnyObject] else {
            return (emotionTone: nil, languageTone: nil, socialTone: nil, error: NSError(domain: "Parsing", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unable to parse JSON with key: \(IBMResponceKeysToneAnalyzer.documentTone)"]))
        }
        guard let toneCategories = documentTone[IBMResponceKeysToneAnalyzer.toneCategories] as! [AnyObject]? else {
            return (emotionTone: nil, languageTone: nil, socialTone: nil, error: NSError(domain: "Parsing", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unable to parse JSON with key: \(IBMResponceKeysToneAnalyzer.toneCategories)"]))
        }
        
        if let emotionTone = toneCategories[0] as? [String: AnyObject] {
            emotionT = parseEmotionsToneObject(emotionTone)
        }
        
        if let languageTone = toneCategories[1] as? [String: AnyObject] {
            languageT = parseLanguageToneObject(languageTone)
        }
        
        if let socialTone = toneCategories[2] as? [String: AnyObject] {
            socialT = parseSocialToneObject(socialTone)
        }
        
        return (emotionTone: emotionT, languageTone: languageT, socialTone: socialT, error: nil)
    }
    
    
    //MARK: Parsing tone categories
    private func parseEmotionsToneObject(emotionTone: [String: AnyObject]) -> [EmotionsTone.Emotions : Double]? {
        
        guard let toneArray = emotionTone[IBMResponceKeysToneAnalyzer.tones] as? [[String: AnyObject]?] else {
            return nil
        }
        
        var emotions: [EmotionsTone.Emotions : Double]
        
        let anger = toneArray[0]![IBMResponceKeysToneAnalyzer.score] as! Double
        emotions = [.Anger: anger]
        
        let disgust = toneArray[1]![IBMResponceKeysToneAnalyzer.score] as! Double
        emotions[.Disgust] = disgust
        
        let fear = toneArray[2]![IBMResponceKeysToneAnalyzer.score] as! Double
        emotions[.Fear] = fear
        
        let joy = toneArray[3]![IBMResponceKeysToneAnalyzer.score] as! Double
        emotions[.Joy] = joy
        
        let sadness = toneArray[4]![IBMResponceKeysToneAnalyzer.score] as! Double
        emotions[.Sadness] = sadness
        
        return emotions
    }
    
    private func parseLanguageToneObject(languageTone: [String: AnyObject]) -> [LanguageTone.Language : Double]? {
        
        guard let toneArray = languageTone[IBMResponceKeysToneAnalyzer.tones] as? [[String: AnyObject]?] else {
            return nil
        }
        
        var language: [LanguageTone.Language : Double]
        
        let analytical = toneArray[0]![IBMResponceKeysToneAnalyzer.score] as! Double
        language = [.Analytical: analytical]
        
        let confident = toneArray[1]![IBMResponceKeysToneAnalyzer.score] as! Double
        language[.Confident] = confident
        
        let tentative = toneArray[2]![IBMResponceKeysToneAnalyzer.score] as! Double
        language[.Tentative] = tentative
        
        return language
    }
    
    private func parseSocialToneObject(socialTone: [String: AnyObject]) -> [SocialTone.Social : Double]? {
        
        guard let toneArray = socialTone[IBMResponceKeysToneAnalyzer.tones] as? [[String: AnyObject]?] else {
            return nil
        }
        
        var social: [SocialTone.Social : Double]
        
        let openness = toneArray[0]![IBMResponceKeysToneAnalyzer.score] as! Double
        social = [.Openness: openness]
        
        let conscientiousness = toneArray[1]![IBMResponceKeysToneAnalyzer.score] as! Double
        social[.Conscientiousness] = conscientiousness
        
        let extraversion = toneArray[2]![IBMResponceKeysToneAnalyzer.score] as! Double
        social[.Extraversion] = extraversion
        
        let agreeableness = toneArray[3]![IBMResponceKeysToneAnalyzer.score] as! Double
        social[.Agreeableness] = agreeableness
        
        let emotionalRange = toneArray[4]![IBMResponceKeysToneAnalyzer.score] as! Double
        social[.EmotionalRange] = emotionalRange
        
        return social
    }
    
}