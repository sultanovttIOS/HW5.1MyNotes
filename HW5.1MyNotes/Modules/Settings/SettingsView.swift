//
//  SettingsViewController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//
import UIKit

class SettingsView: UIViewController {
    
    private lazy var settingsTableView = UITableView()
    
    private lazy var images: [SetImageTitleStruct] = [SetImageTitleStruct(image: "language_icon", title: "Язык"),
                                        SetImageTitleStruct(image: "them_icon", title: "Темная тема"),
                                        SetImageTitleStruct(image: "delete_icon", title: "Очистить данные")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavigationItem()
        setupConstraints()
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reiseID)
    }
    
    private func setupConstraints() {
        view.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(151)
        }
        settingsTableView.layer.cornerRadius = 10
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
        
        let rightBarButton = UIBarButtonItem(customView: customButton)
        navigationItem.rightBarButtonItem = rightBarButton
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
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
