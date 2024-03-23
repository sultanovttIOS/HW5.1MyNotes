//
//  ViewCenter.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

import UIKit
import SnapKit

struct SettingsStruct {
    let image: String
    let title: String
    let type: SettingsCellType
    let description: String
}

enum SettingsCellType {
    case withSwitch
    case withButton
    case none
}

class SettingsCell: UITableViewCell {
    weak var delegate: SettingsCellDelegate?
    
    static let reiseID = "settings_cell"
    
    private lazy var photoView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .label
        return view
    }()
    
    private lazy var titleLabel = MakerView.shared.makerLabel(numberOfLines: 1, font: .systemFont(ofSize: 17))
    
    private lazy var rightButton: UIButton = {
        let view = UIButton(type: .system)
        let image = UIImage(named: "rightButton_icon")
        let desiredSize = CGSize(width: 8, height: 13.8)
        let scaledImage = image?.resized(to: desiredSize)
        view.tintColor = UIColor(named: "CustomTextColor")
        view.setTitleColor(.label, for: .normal)
        view.setImage(scaledImage, for: .normal)
        view.semanticContentAttribute = .forceRightToLeft
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        return view
    }()
    
    var switchButton: UISwitch = {
        let view = UISwitch()
        view.isOn = UserDefaults.standard.bool(forKey: "theme")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        contentView.backgroundColor = .secondarySystemBackground
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with: SettingsStruct) {
        photoView.image = UIImage(named: with.image)?.withRenderingMode(.alwaysTemplate)
        titleLabel.text = with.title
        rightButton.setTitle(with.description, for: .normal)
        switch with.type {
        case .withSwitch:
            if UserDefaults.standard.bool(forKey: "theme") == true {
                switchButton.isOn = true
            } else {
                switchButton.isOn = false
            }
            rightButton.isHidden = true
            switchButton.isHidden = false
        case .withButton:
            switchButton.isHidden = true
            rightButton.isHidden = false
        case .none:
            rightButton.isHidden = true
            switchButton.isHidden = true
        }
    }
    
    private func setupConstraints() {
        contentView.addSubview(photoView)
        photoView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(photoView.snp.trailing).offset(13)
            make.height.equalTo(24)
        }
        contentView.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).offset(-25)
            make.centerY.equalTo(contentView)
            make.height.equalTo(20)
        }
        contentView.addSubview(switchButton)
        switchButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.trailing.equalTo(contentView).offset(-25)
            make.width.equalTo(51)
            make.height.equalTo(31)
            switchButton.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        }
    }
    @objc func switchValueChanged(_ sender: UISwitch) {
        delegate?.didChangeTheme(isOn: switchButton.isOn)
    }
}
