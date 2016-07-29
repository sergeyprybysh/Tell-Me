//
//  DescriptionText.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 7/21/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import Foundation

struct EmotionsDescription {
    
    private static let anger = "Evoked due to injustice, conflict, humiliation, negligence or betrayal. If anger is active, the individual attacks the target, verbally or physically. If anger is passive, the person silently sulks and feels tension and hostility."
    
    private static let disgust = "An emotional response of revulsion to something considered offensive or unpleasant. It is a sensation that refers to something revolting."
    
    private static let fear = "A response to impending danger. It is a survival mechanism that is a reaction to some negative stimulus. It may be a mild caution or an extreme phobia."
    
    private static let joy = "Joy or happiness has shades of enjoyment, satisfaction and pleasure. There is a sense of well-being, inner peace, love, safety and contentment."
    
    private static let sadness = "Indicates a feeling of loss and disadvantage. When a person can be observed to be quiet, less energetic and withdrawn, it may be inferred that sadness exists."
    
    static let tone = ["Anger", "Disgust", "Fear", "Joy", "Sadness"]
    
    static let description = [anger, disgust, fear, joy, sadness]
}

struct LanguageDescription {
    
    private static let analytic = "A person's reasoning and analytical attitude about things. Less than 0.25 - the text contains little or no evidence of analytical tone.More than 0.75 - more likely to be perceived as intellectual, rational, systematic, emotionless, or impersonal."
    
    private static let confidence = "A persons degree of certainty. Less than 0.25 - the text contains little or no evidence of confidence in tone. More than 0.75 - more likely to be perceived as assured, collected, hopeful, or egotistical."
    
    private static let tentative = "A persons degree of inhibition. Less than 0.25 - the text contains little or no evidence of tentativeness in tone. More than 0.75 - more likely to be perceived as questionable, doubtful, limited, or debatable."
    
    static let tone = ["Analytic", "Confidence", "Tentative"]
    
    static let description = [analytic, confidence, tentative]
}

struct SocialDescription {
    
    private static let openness = "The extent a person is open to experience a variety of activities."
    
    private static let conscientiousness = "The tendency to act in an organized or thoughtful way."
    
    private static let extraversion = "The tendency to seek stimulation in the company of others."
    
    private static let agreeableness = "The tendency to be compassionate and cooperative towards others."
    
    private static let emotionalRange = "The extent a personâ's emotion is sensitive to the environment."
    
    static let tone = ["Openness", "Conscientiousness", "Extraversion", "Agreeableness", "Emotional Range"]
    
    static let description = [openness, conscientiousness, extraversion, agreeableness, emotionalRange ]
}