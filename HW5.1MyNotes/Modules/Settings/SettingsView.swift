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
    func didChangeLanguage()
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
        SettingsStruct(image: "language_icon", title: "Язык", type: .withButton),
        SettingsStruct(image: "them_icon", title: "Темная тема", type: .withSwitch),
        SettingsStruct(image: "delete_icon", title: "Очистить данные", type: .none)]
    
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
        navigationItem.title = "Settings"
        
        let customLeftButton = UIButton(type: .system)
        customLeftButton.tintColor = .black
        customLeftButton.setTitle("Home", for: .normal)
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
            let alert = UIAlertController(title: "Удаление", message: "Удалить все заметки?", preferredStyle: .alert)
            let acceptAlert = UIAlertAction(title: "Удалить", style: .destructive) { action in
                self.controller?.onDeleteNotes()
            }
            let actionDecline = UIAlertAction(title: "Отменить", style: .cancel)
            alert.addAction(actionDecline)
            alert.addAction(acceptAlert)
            present(alert, animated: true)
        }
    }
}
extension SettingsView: SettingsViewProtocol {
    func successDelete() {
        navigationController?.popViewController(animated: true)
    }
    func failureDelete() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось удалить заметки!", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "OK", style: .cancel)
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
    func didChangeLanguage() {
        present(LanguageView(), animated: true)
    }
}
