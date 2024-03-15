//
//  CoreDataService.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 14/3/24.
//  Created by Alisher Sultanov on 12/3/24.
//

import UIKit
import CoreData

// CRUD - Create, Read, Update, Delete
// POST - create
// GET(FETCH) - read
// PUT(PATCH) - update
// DELETE - delete

class CoreDataService {
    
    static let shared = CoreDataService()
    
    private init() {
        
    }
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    // post - запись
    func addNote(id: String, title: String, description: String, date: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else { return }
        
        let note = Note(entity: entity, insertInto: context)
        note.id = id
        note.title = title
        note.desc = description
        note.date = date
        
        appDelegate.saveContext()
    }
    // get, fetch - считать
    func fetchNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            return try context.fetch(fetchRequest) as! [Note]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func updateNote(id: String, title: String, description: String, date: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
                note.id == id
            }) else { return }
            note.title = title
            note.desc = description
            note.date = date
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    func delete(id: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note], let note = notes.first(where: { note in
                note.id == id
            }) else { return }
            context.delete(note)
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
    
    func deleteNotes() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            guard let notes = try context.fetch(fetchRequest) as? [Note] else { return }
            notes.forEach { note in context.delete(note)
            }
        } catch {
            print(error.localizedDescription)
        }
        appDelegate.saveContext()
    }
}
