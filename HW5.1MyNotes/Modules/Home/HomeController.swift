//
//  HomeController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

protocol HomeControllerProtocol {
    func onGetNotes()
    
    func onSuccessNotes(notes: [String])}

class HomeController: HomeControllerProtocol {
    
    private let view: HomeViewProtocol? 
    
    private var model: HomeModelProtocol?
    
    init(view: HomeViewProtocol?) {
        self.view = view
        self.model = HomeModel(controller: self)
    }
    
    func onGetNotes() {
        model?.getNotes()
    }
    
    func onSuccessNotes(notes: [String]) {
        view?.successNotes(notes: notes)
    }
    
    
}
