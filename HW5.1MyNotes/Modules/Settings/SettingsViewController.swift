//
//  SettingsViewController.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//
import UIKit

class SettingsViewController: UIViewController {
    
    private lazy var stackView = MakerView.shared.makerStackView(backgroundColor: .lightGray)
    
    private lazy var firstView = FirstCustomView()
    
    private lazy var secondView = SecondCustomView()
    
    private lazy var thirdView = ThirdCustomView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupNavigationItem()
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(200)
            stackView.addArrangedSubview(firstView)
            stackView.addArrangedSubview(secondView)
            stackView.addArrangedSubview(thirdView)
        }
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Settings"
        
        let customButton = UIButton(type: .system)
        let image = UIImage(named: "settings_icon")
        let desiredSize = CGSize(width: 25, height: 25)
        let scaledImage = image?.resized(to: desiredSize)
        customButton.setImage(scaledImage, for: .normal)
        customButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        
        let rightBarButton = UIBarButtonItem(customView: customButton)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func settingsButtonTapped(_ sender: UIButton) {
        
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
