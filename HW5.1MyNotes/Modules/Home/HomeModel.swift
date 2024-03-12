//
//  HomeModel.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//
protocol HomeModelProtocol {
    func getNotes()
}
class HomeModel: HomeModelProtocol {
    
    private let controller: HomeControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    init(controller: HomeControllerProtocol?) {
        self.controller = controller
    }

    private var notes: [Note] = []
    
    func getNotes() {
        notes = coreDataService.fetchNotes()
        controller?.onSuccessNotes(notes: notes)
    }
}
