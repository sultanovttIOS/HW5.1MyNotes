//
//  SettingsViewController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

import UIKit

protocol SettingsViewProtocol {
    func successDelete()
    func failureDelete()
}
protocol SettingsCellDelegate: AnyObject {
    func didChangeTheme(isOn: Bool)
}

class SettingsView: UIViewController {
    private var controller: SettingsControllerProtocol?
    
    private lazy var settingsTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reiseID)
        view.isScrollEnabled = false
        return view
    }()
    
    private lazy var setData: [SettingsStruct] = [
        SettingsStruct(image: "language_icon", title: "Choose language".localized(), type: .withButton),
        SettingsStruct(image: "them_icon", title: "Choose theme".localized(), type: .withSwitch),
        SettingsStruct(image: "delete_icon", title: "Clear data".localized(), type: .none)]
    
    deinit {
        print("Экран Settings уничтожился с памяти!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            UserDefaults.standard.bool(forKey: "theme")
            view.overrideUserInterfaceStyle = .light
        }
        setupNavigationItem()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupConstraints()
        controller = SettingsController(view: self)
    }
    private func setupData() {
        setData = [SettingsStruct(image: "language_icon", title: "Choose language".localized(), type: .withButton),
                   SettingsStruct(image: "them_icon", title: "Choose theme".localized(), type: .withSwitch),
                   SettingsStruct(image: "delete_icon", title: "Clear data".localized(), type: .none)]
        settingsTableView.reloadData()
    }
    
    private func setupConstraints() {
        view.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(151)
        }
        settingsTableView.layer.cornerRadius = 10
        settingsTableView.backgroundColor = .secondarySystemBackground
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Settings".localized()
        
        let customLeftButton = UIButton(type: .system)
        customLeftButton.tintColor = .black
        customLeftButton.setTitle("Home".localized(), for: .normal)
        customLeftButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        if UserDefaults.standard.bool(forKey: "theme") == true {
            customLeftButton.tintColor = .white
        } else {
            customLeftButton.tintColor = .black
        }
        let leftBarButton = UIBarButtonItem(customView: customLeftButton)
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func backButtonTap() {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        setData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reiseID,
                                                 for: indexPath) as! SettingsCell
        cell.delegate = self
        cell.fill(with: setData[indexPath.row])
        return cell
    }
}
extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            let alert = UIAlertController(title: "Delete".localized(), message: "Delete all notes?".localized(), preferredStyle: .alert)
            let acceptAlert = UIAlertAction(title: "Delete".localized(), style: .destructive) { action in
                self.controller?.onDeleteNotes()
            }
            let actionDecline = UIAlertAction(title: "Cancel".localized(), style: .cancel)
            alert.addAction(actionDecline)
            alert.addAction(acceptAlert)
            present(alert, animated: true)
        } else if indexPath.row == 0 {
            let languageView = LanguageView()
            languageView.delegate = self
            let multiplier = 0.28
            let customDetent = UISheetPresentationController.Detent.custom(resolver: { context in
                languageView.view.frame.height * multiplier
            })
            if let sheet = languageView.sheetPresentationController {
                sheet.detents = [customDetent, .medium()]
                sheet.prefersGrabberVisible = true
                self.present(languageView, animated: true)
            }
        }
    }
}
extension SettingsView: SettingsViewProtocol {
    func successDelete() {
        navigationController?.popViewController(animated: true)
    }
    func failureDelete() {
        let alert = UIAlertController(title: "Error".localized(), message: "Failed to delete notes!".localized(), preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "OK".localized(), style: .cancel)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
}
extension SettingsView: SettingsCellDelegate {
    func didChangeTheme(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: "theme")
        if isOn {
            view.overrideUserInterfaceStyle = .dark
        }  else {
            view.overrideUserInterfaceStyle = .light
        }
    }
}
extension SettingsView: LanguageViewProtocol {
    func didChangeLanguage(languageType: LanguageType) {
      setupNavigationItem()
        setupData()
    }
}
