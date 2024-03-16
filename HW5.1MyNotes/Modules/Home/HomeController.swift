//
//  HomeController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

protocol HomeControllerProtocol {
    func onGetNotes()
    func onSuccessNotes(notes: [Note])
    func onNoteSearching(text: String)
    func onSearchResult(notes: [Note])
}

class HomeController: HomeControllerProtocol {
    private let view: HomeViewProtocol? 
    
    private var model: HomeModelProtocol?
    
    init(view: HomeViewProtocol) {
        self.view = view
        self.model = HomeModel(controller: self)
    }
    
    func onGetNotes() {
        model?.getNotes()
    }
    
    func onSuccessNotes(notes: [Note]) {
        view?.successNotes(notes: notes)
    }
    
    func onNoteSearching(text: String) {
        model?.searchNotes(text: text)
    }
    
    func onSearchResult(notes: [Note]) {
        view?.successNotes(notes: notes)
    }
}
