//
//  SocialTone.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 7/3/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import Foundation
import CoreData

class SocialTone: NSManagedObject {
    
    @NSManaged var openness: Double
    @NSManaged var conscientiousness: Double
    @NSManaged var extraversion: Double
    @NSManaged var agreeableness: Double
    @NSManaged var emotionalRange: Double
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(social: [Social: Double], context: NSManagedObjectContext) {
        
        let entity =  NSEntityDescription.entityForName("SocialTone", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.openness = social[.Openness]!
        self.conscientiousness = social[.Conscientiousness]!
        self.extraversion = social[.Extraversion]!
        self.agreeableness = social[.Agreeableness]!
        self.emotionalRange = social[.EmotionalRange]!
    }
    
    enum Social {
        case Openness, Conscientiousness, Extraversion, Agreeableness, EmotionalRange
    }
}
