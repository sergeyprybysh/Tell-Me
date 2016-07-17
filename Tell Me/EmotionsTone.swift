//
//  EmotionsTone.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 7/3/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import Foundation
import CoreData

class EmotionsTone: NSManagedObject {
    
    @NSManaged var anger: Double
    @NSManaged var disgust: Double
    @NSManaged var fear: Double
    @NSManaged var joy: Double
    @NSManaged var sadness: Double
    
    @NSManaged var textObject: TextObject?
    
    let chartStrings = ["Anger", "Disgust", "Fear", "Joy", "Sadness"]
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(emotions: [Emotions: Double], context: NSManagedObjectContext) {
        
        let entity =  NSEntityDescription.entityForName("EmotionsTone", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.anger = emotions[.Anger]!
        self.disgust = emotions[.Disgust]!
        self.fear = emotions[.Fear]!
        self.joy = emotions[.Joy]!
        self.sadness = emotions[.Sadness]!
    }
    
    enum Emotions {
        case Anger, Disgust, Fear, Joy, Sadness
    }
}
