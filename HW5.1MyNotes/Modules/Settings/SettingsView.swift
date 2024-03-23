//
//  SettingsViewController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
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
        SettingsStruct(image: "language_icon", title: "Choose language".localized(),
                       type: .withButton, description: "English".localized()),
        SettingsStruct(image: "them_icon", title: "Choose theme".localized(),
                       type: .withSwitch, description: ""),
        SettingsStruct(image: "delete_icon", title: "Clear data".localized(),
                       type: .none, description: "")]
    
    func updateSettingsLanguage() {
        setData = [SettingsStruct(image: "language_icon", title: "Choose language".localized(),
                                  type: .withButton, description: "English".localized()),
                   SettingsStruct(image: "them_icon", title: "Choose theme".localized(),
                                  type: .withSwitch, description: ""),
                   SettingsStruct(image: "delete_icon", title: "Clear data".localized(),
                                  type: .none, description: "")]
        settingsTableView.reloadData()
        setupNavigationItem()
    }
    
    deinit {
        print("Экран Settings уничтожился с памяти!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingsTableView.reloadData()
        // MARK: update navigationItem tintColor
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main) { _ in
            self.setupNavigationItem()
        }
        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
            navigationItem.titleView?.tintColor = .white
        } else {
            UserDefaults.standard.bool(forKey: "theme")
            view.overrideUserInterfaceStyle = .light
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavigationItem()
        setupConstraints()
        controller = SettingsController(view: self)
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
            let titleText = UILabel()
            titleText.text = "Settings".localized()
            if UserDefaults.standard.bool(forKey: "theme") == true {
                titleText.textColor = .white
            } else {
                titleText.textColor = .black
            }
            navigationItem.titleView = titleText
    
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
            let multiplier = 0.30
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
        updateSettingsLanguage()
    }
}
