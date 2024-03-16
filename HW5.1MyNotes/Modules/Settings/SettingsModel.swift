//
//  SettingsModel.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 1/3/24.
//

protocol SettingsModelProtocol {
    
}

class SettingsModel {
    
    weak var controller: SettingsControllerProtocol?
    
    init(controller: SettingsControllerProtocol) {
        self.controller = controller
    }
}

extension SettingsModel: SettingsModelProtocol {
    
}
