//
//  Note+CoreDataProperties.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 12/3/24.
//
//

import Foundation
import CoreData

extension Note {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var date: String?
    
}

extension Note : Identifiable {
    
}
