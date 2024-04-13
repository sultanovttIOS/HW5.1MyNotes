//
//  HomeModel.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//
protocol HomeModelProtocol {
    func getNotes()
    
    func searchNotes(text: String)
}
class HomeModel: HomeModelProtocol {
    
    private let controller: HomeControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    init(controller: HomeControllerProtocol?) {
        self.controller = controller
    }

    private var notes: [Note] = []
    private var filteredNotes: [Note] = []

    func getNotes() {
        notes = coreDataService.fetchNotes()
        controller?.onSuccessNotes(notes: notes)
    }
    
    func searchNotes(text: String) {
        filteredNotes = []
        if text.isEmpty {
            filteredNotes = notes
            controller?.onSuccessNotes(notes: notes)
        } else {
            filteredNotes = notes.filter({ note in 
                note.title!.lowercased().contains(text.lowercased())
            })
            controller?.onSuccessNotes(notes: filteredNotes)
        }
    }
}
