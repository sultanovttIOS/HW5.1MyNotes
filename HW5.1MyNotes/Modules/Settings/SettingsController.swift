//
//  SettingsController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 1/3/24.
//

protocol SettingsControllerProtocol: AnyObject {
    func onDeleteNotes()
    func onSuccessDelete()
    func onFailureDelete()
}

class SettingsController {
    
    weak var view: SettingsViewProtocol?
    private var model: SettingsModelProtocol?
    
    init(view: SettingsViewProtocol) {
        self.view = view
        self.model = SettingsModel(controller: self)
    }
}

extension SettingsController: SettingsControllerProtocol {
    func onSuccessDelete() {
        view?.successDelete()
    }
    
    func onFailureDelete() {
        view?.failureDelete()
    }
    
    func onDeleteNotes() {
        model?.deleteNotes()
    }
}

