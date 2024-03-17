//
//  SettingsModel.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 1/3/24.
//

protocol SettingsModelProtocol {
    func deleteNotes()
}

class SettingsModel {
    private let coreDataService = CoreDataService.shared
    
    weak var controller: SettingsControllerProtocol?
    
    init(controller: SettingsControllerProtocol) {
        self.controller = controller
    }
}

extension SettingsModel: SettingsModelProtocol {
    func deleteNotes() {
        coreDataService.deleteNotes() { response in
            if response == .success {
                self.controller?.onSuccessDelete()
            } else {
                self.controller?.onFailureDelete()
            }
        }
    }
}
