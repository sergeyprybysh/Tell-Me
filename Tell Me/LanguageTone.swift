//
//  LanguageTone.swift
//  Tell Me
//
//  Created by Sergey Prybysh on 7/3/16.
//  Copyright © 2016 Spryby. All rights reserved.
//

import Foundation
import CoreData

class LanguageTone: NSManagedObject {
    
    @NSManaged var analytical: Double
    @NSManaged var confident: Double
    @NSManaged var tentative: Double
    
    @NSManaged var textObject: TextObject?
    
    let chartStrings = ["Analytical", "Confident", "Tentative"]
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(language: [Language: Double], context: NSManagedObjectContext) {
        
        let entity =  NSEntityDescription.entityForName("LanguageTone", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        self.analytical = language[.Analytical]!
        self.confident = language[.Confident]!
        self.tentative = language[.Tentative]!
    }
    
    enum Language {
        case Analytical, Confident, Tentative
    }
}
