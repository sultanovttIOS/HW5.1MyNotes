//
//  LanguageController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 21/3/24.
//

import UIKit
protocol LanguageControllerProtocol: AnyObject {
    func onChangeLanguage(language: LanguageType)
    func onSuccessChangeLanguage(language: LanguageType)
}
class LanguageController {
    private var model: LanguageModelProtocol?
    weak var view: LanguageViewProtocol?
    
    init(view: LanguageViewProtocol) {
        self.view = view
        self.model = LanguageModel(controller: self)
    }
}
extension LanguageController: LanguageControllerProtocol {
    func onChangeLanguage(language: LanguageType) {
        model?.changeLanguage(language: language)
    }
    func onSuccessChangeLanguage(language: LanguageType) {
        view?.didChangeLanguage(languageType: language)
    }
}
