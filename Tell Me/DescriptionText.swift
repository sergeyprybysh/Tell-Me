//
//  DescriptionText.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 7/21/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import Foundation

struct EmotionsDescription {
    
    private static let anger = "Evoked due to injustice, conflict, humiliation, negligence or betrayal. If anger is active, the individual attacks the target, verbally or physically. If anger is passive, the person silently sulks and feels tension and hostility. < 0.5 - less likely to be perceived as angry. > 0.75 - Highly likely to be perceived as angry."
    
    private static let disgust = "An emotional response of revulsion to something considered offensive or unpleasant. It is a sensation that refers to something revolting. < 0.5 - less likely to be perceived as disgusted. > 0.75 - Highly likely to be perceived as disgusted."
    
    private static let fear = "A response to impending danger. It is a survival mechanism that is a reaction to some negative stimulus. It may be a mild caution or an extreme phobia. < 0.5 - less likely to be perceived as scared. > 0.75 - Highly likely to be perceived as scared."
    
    private static let joy = "Joy or happiness has shades of enjoyment, satisfaction and pleasure. There is a sense of well-being, inner peace, love, safety and contentment. < 0.5 - less likely to be perceived as joyful. > 0.75 - Highly likely to be perceived as joyful."
    
    private static let sadness = "Indicates a feeling of loss and disadvantage. When a person can be observed to be quiet, less energetic and withdrawn, it may be inferred that sadness exists. < 0.5 - less likely to be perceived as sad. > 0.75 - Highly likely to be perceived as sad."
    
    static let tone = ["Anger", "Disgust", "Fear", "Joy", "Sadness"]
    
    static let description = [anger, disgust, fear, joy, sadness]
}

struct LanguageDescription {
    
    private static let analytic = "A person's reasoning and analytical attitude about things. < 0.25 - the text contains little or no evidence of analytical tone. > 0.75 - more likely to be perceived as intellectual, rational, systematic, emotionless, or impersonal."
    
    private static let confidence = "A persons degree of certainty. < 0.25 - the text contains little or no evidence of confidence in tone. > 0.75 - more likely to be perceived as assured, collected, hopeful, or egotistical."
    
    private static let tentative = "A persons degree of inhibition. < 0.25 - the text contains little or no evidence of tentativeness in tone. > 0.75 - more likely to be perceived as questionable, doubtful, limited, or debatable."
    
    static let tone = ["Analytic", "Confidence", "Tentative"]
    
    static let description = [analytic, confidence, tentative]
}

struct SocialDescription {
    
    private static let openness = "The extent a person is open to experience a variety of activities. < 0.25 - more likely to be perceived as straightforward, blunt, or preferring tradition and the obvious over the complex, ambiguous, and subtle. > 0.75 - more likely to be perceived as intellectual, curious, imaginative, appreciating beauty, or open to change."
    
    private static let conscientiousness = "The tendency to act in an organized or thoughtful way. < 0.25 - more likely to be perceived as spontaneous, laid-back, reckless, unmethodical, remiss, or disorganized. > 0.75 - more likely to be perceived as disciplined, dutiful, achievement-striving, confident, driven, or organized."
    
    private static let extraversion = "The tendency to seek stimulation in the company of others. < 0.25 - more likely to be perceived as independent, timid, introverted, restrained, boring, or dreary. > 0.75 - more likely to be perceived as engaging, seeking attention, needy, outgoing, sociable, cheerful, excitement-seeking, or busy."
    
    private static let agreeableness = "The tendency to be compassionate and cooperative towards others. < 0.25 - more likely to be perceived as selfish, uncaring, uncooperative, self-interested, confrontational, skeptical, or arrogant. > 0.75 - more likely to be perceived as caring, sympathetic, cooperative, compromising, trustworthy, or humble."
    
    private static let emotionalRange = "The extent a personâ's emotion is sensitive to the environment. < 0.25 - more likely to be perceived as calm, bland, content, relaxed, unconcerned, or careful. > 0.75 - more likely to be perceived as concerned, frustrated, angry, passionate, upset, stressed, insecure, or impulsive."
    
    static let tone = ["Openness", "Conscientiousness", "Extraversion", "Agreeableness", "Emotional Range"]
    
    static let description = [openness, conscientiousness, extraversion, agreeableness, emotionalRange ]
}