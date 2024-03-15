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
    
    private let coreDataService = CoreDataService.shared
    
    weak var controller: SettingsControllerProtocol?
    
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
        print("Экран Settings уничтожился")
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
        
//        let customButton = UIButton(type: .system)
//        let image = UIImage(named: "settings_icon")
//        let desiredSize = CGSize(width: 25, height: 25)
//        let scaledImage = image?.resized(to: desiredSize)
//        customButton.setImage(scaledImage, for: .normal)
//        customButton.tintColor = .black
//        customButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
//        
//        if UserDefaults.standard.bool(forKey: "theme") == true {
//            customButton.tintColor = .white
//        } else {
//            customButton.tintColor = .black
//        }
//        let rightBarButton = UIBarButtonItem(customView: customButton)
//        navigationItem.rightBarButtonItem = rightBarButton

//        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
//        if UserDefaults.standard.bool(forKey: "theme") == true {
//            rightBarButton.tintColor = .white
//        } else {
//            rightBarButton.tintColor = .black
//        }
//        navigationItem.rightBarButtonItem = rightBarButton
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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            coreDataService.deleteNotes()
        }
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
