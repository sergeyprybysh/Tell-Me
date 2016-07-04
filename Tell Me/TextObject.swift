//
//  TextObject.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 7/3/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import Foundation
import CoreData

class TextObject: NSManagedObject {
    
    @NSManaged var text: String
    @NSManaged var confidence: Double
    
    @NSManaged var emotionsTone: EmotionsTone?
    @NSManaged var languageTone: LanguageTone?
    @NSManaged var socialTone: SocialTone?
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(text: String, confidence: Double, context: NSManagedObjectContext) {
        
        let entity =  NSEntityDescription.entityForName("TextObject", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.text = text
        self.confidence = confidence
    }
}
