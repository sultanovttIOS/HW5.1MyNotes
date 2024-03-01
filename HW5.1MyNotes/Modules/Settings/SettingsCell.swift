//
//  ViewCenter.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

import UIKit
import SnapKit

class SettingsCell: UITableViewCell {
        
    static let reiseID = "settings_cell"
    
    private lazy var photoView = MakerView.shared.makerImageView(imageName: "")
    
    private lazy var titleLabel = MakerView.shared.makerLabel(text: "Язык", numberOfLines: 1, font: .systemFont(ofSize: 17))
    
    private lazy var languageLabel = MakerView.shared.makerLabel(text: "Русский", numberOfLines: 1, font: .systemFont(ofSize: 14))

    private lazy var rightButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "Русский"
        configuration.titleAlignment = .leading
        configuration.image = UIImage(named: "rightButton_icon")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 10
        let view = UIButton(configuration: configuration)
        view.tintColor = .black
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(_ imageName: String) {
        photoView.image = UIImage(named: imageName)
    }
    
    private func setupConstraints() {
        backgroundColor = .systemGray6
        clipsToBounds = true
        contentView.addSubview(photoView)
        photoView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.width.height.equalTo(22)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(photoView.snp.trailing).offset(10)
            make.width.equalTo(43)
            make.height.equalTo(24)
        }
        contentView.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(125)
        }
    }
}

