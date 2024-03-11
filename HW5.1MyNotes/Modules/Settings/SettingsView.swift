//
//  SettingsViewController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

import UIKit

protocol SettingsViewProtocol {
    
}

class SettingsView: UIViewController {
    
    weak var controller: SettingsControllerProtocol?
    
    private lazy var settingsTableView = UITableView()
    
    private lazy var images: [SetImageTitleStruct] = [SetImageTitleStruct(image: "language_icon", title: "Язык"),
                                        SetImageTitleStruct(image: "them_icon", title: "Темная тема"),
                                        SetImageTitleStruct(image: "delete_icon", title: "Очистить данные")]
    
    deinit {
        print("Экран Settings уничтожился")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationItem()

        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupConstraints()
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reiseID)
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
        
        let customButton = UIButton(type: .system)
        let image = UIImage(named: "settings_icon")
        let desiredSize = CGSize(width: 25, height: 25)
        let scaledImage = image?.resized(to: desiredSize)
        customButton.setImage(scaledImage, for: .normal)
        customButton.tintColor = .black
        customButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        if UserDefaults.standard.bool(forKey: "theme") == true {
            customButton.tintColor = .white
        } else {
            customButton.tintColor = .black
        }
        let rightBarButton = UIBarButtonItem(customView: customButton)
        navigationItem.rightBarButtonItem = rightBarButton
//        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
//        if UserDefaults.standard.bool(forKey: "theme") == true {
//            rightBarButton.tintColor = .white
//        } else {
//            rightBarButton.tintColor = .black
//        }
//        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func settingsButtonTapped(_ sender: UIButton) {
        
    }
}

extension SettingsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reiseID,
                                                 for: indexPath) as! SettingsCell
        cell.delegate = self
        if indexPath.row == 0 {
            cell.contentView.addSubview(cell.rightButton)
        } else {
            cell.rightButton.removeFromSuperview()
        }
        if indexPath.row == 1 {
            cell.contentView.addSubview(cell.switchButton)
        } else {
            cell.switchButton.removeFromSuperview()
        }
        cell.fill(images[indexPath.row].image, title: images[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

extension SettingsView: SettingsViewProtocol {
    
}

extension SettingsView: ThemeSwitchDelegate {
    func didChangeTheme(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: "theme")
        if isOn {
            view.overrideUserInterfaceStyle = .dark
        }  else {
            view.overrideUserInterfaceStyle = .light
        }
    }
}
