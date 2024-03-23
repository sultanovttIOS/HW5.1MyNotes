//
//  NoteController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 16/3/24.
//

import UIKit

protocol NoteControllerProtocol: AnyObject {
    func onAddNote(note: Note?, title: String, description: String)
    func onSuccessAddNote()
    func onFailureAddNote()
    func onDeleteNote(id: String)
    func onSuccessDelete()
    func onFailureDelete()
    func onSuccessUpdateNote(note: Note?, id: String, title: String, description: String, date: String)
}

class NoteController: NoteControllerProtocol {
    weak var view: NoteViewProtocol?
    var model: NoteModelProtocol?
    
    init(view: NoteViewProtocol) {
        self.view = view
        self.model = NoteModel(controller: self)
    }
    
    func onAddNote(note: Note?, title: String, description: String) {
        model?.addNote(note: note, title: title, description: description)
    }
    func onSuccessAddNote() {
        view?.successAddNote()
    }
    func onFailureAddNote() {
        view?.failureAddNote()
    }
    func onDeleteNote(id: String) {
        model?.deleteNote(id: id)
    }
    func onSuccessDelete() {
        view?.successDelete()
    }
    func onFailureDelete() {
        view?.failureDelete()
    }
    func onSuccessUpdateNote(note: Note?, id: String, title: String, description: String, date: String) {
        view?.successUpdateNote()
    }
}
