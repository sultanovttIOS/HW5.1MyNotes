//
//  NoteController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 16/3/24.
//

import UIKit

protocol NoteControllerProtocol {
    func onAddNote(note: Note?, id: String, title: String, description: String, date: String)
    func onSuccessAddNote()
    func onFailureAddNote()
}

class NoteController: NoteControllerProtocol {
    private let view: NoteViewProtocol?
    var model: NoteModelProtocol?
    
    init(view: NoteViewProtocol) {
        self.view = view
        self.model = NoteModel(controller: self)
    }
    
    func onAddNote(note: Note?, id: String, title: String, description: String, date: String) {
        model?.addNote(note: note, id: id, title: title, description: description, date: date)
    }
    func onSuccessAddNote() {
        view?.succesNote()
    }
    func onFailureAddNote() {
        ()
    }
}
