//
//  NoteModel.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 16/3/24.
//

import UIKit

protocol NoteModelProtocol {
    func addNote(note: Note?, id: String, title: String, description: String, date: String)
}

class NoteModel: NoteModelProtocol {
    private let coreDataService = CoreDataService.shared
    var controller: NoteControllerProtocol?
    
    init(controller: NoteControllerProtocol) {
        self.controller = controller
    }
    
    func addNote(note: Note?, id: String, title: String, description: String, date: String) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: currentDate)
        if let note = note {
            coreDataService.updateNote(id: note.id ?? "", title: title, description: description, date: date)
            //TODO: потом переделать
            //controller.popViewController(animated: true)
        } else {
            let id = UUID().uuidString
            coreDataService.addNote(id: id, title: title, description: description, date: dateString)
            //TODO: потом переделать
            //controller.o.popViewController(animated: true)
            controller?.onSuccessAddNote()
        }
    }
}
