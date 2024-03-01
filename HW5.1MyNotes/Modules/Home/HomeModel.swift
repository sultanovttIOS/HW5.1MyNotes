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
    
    init(controller: HomeControllerProtocol?) {
        self.controller = controller
    }
    
    func getNotes() {
        controller?.onSuccessNotes(notes: notes)
    }
    
    private var notes: [String] = ["Schools notes", "Funny jokes", "Travel basket list", "Do homework"]

}
