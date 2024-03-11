//
//  SettingsController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 1/3/24.
//

protocol SettingsControllerProtocol: AnyObject {
    
}

class SettingsController {
    
    private let view: SettingsViewProtocol?
    private var model: SettingsModelProtocol?
    
    init(view: SettingsViewProtocol?) {
        self.view = view
        self.model = SettingsModel(controller: self)
    }
}

extension SettingsController: SettingsControllerProtocol {
    
}

