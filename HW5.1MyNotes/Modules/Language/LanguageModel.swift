//
//  LanguageModel.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 21/3/24.
//

import UIKit

protocol LanguageModelProtocol {
    func changeLanguage(language: LanguageType)
}
class LanguageModel {
    private let appLanguageManager = AppLanguageManager.shared
    
    weak var controller: LanguageControllerProtocol?
    
    init(controller: LanguageControllerProtocol) {
        self.controller = controller
    }
}

extension LanguageModel: LanguageModelProtocol {
    func changeLanguage(language: LanguageType) {
        appLanguageManager.setAppLanguage(language: language)
        controller?.onSuccessChangeLanguage(language: language)
    }
}
