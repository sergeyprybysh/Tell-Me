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
    
    let emotions = ["Anger", "Disgust", "Fear", "Joy", "Sadness"]
    
    let level = ["0.5 / 0.75", "0.5 / 0.75", "0.5 / 0.75", "0.5 / 0.75", "0.5 / 0.75"]
    
    let description = [anger, disgust, fear, joy, sadness]
}

struct LanguageDescription {
    
    let emotions = ["Anger", "Disgust", "Fear", "Joy", "Sadness"]
    
    let level = ["0.5 / 0.75", "0.5 / 0.75", "0.5 / 0.75", "0.5 / 0.75", "0.5 / 0.75"]
    
    let description = [""]
}

struct SocialDescription {
    
    let emotions = ["Anger", "Disgust", "Fear", "Joy", "Sadness"]
    
    let level = ["0.5 / 0.75", "0.5 / 0.75", "0.5 / 0.75", "0.5 / 0.75", "0.5 / 0.75"]
    
    let description = [""]
}