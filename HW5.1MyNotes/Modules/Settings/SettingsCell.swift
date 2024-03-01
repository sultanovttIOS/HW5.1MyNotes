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
    
    private lazy var photoView = UIImageView()
    
    private lazy var titleLabel = MakerView.shared.makerLabel(numberOfLines: 1, font: .systemFont(ofSize: 17))
    
    var rightButton: UIButton = {
        let view = UIButton(type: .system)
        let image = UIImage(named: "rightButton_icon")
        let desiredSize = CGSize(width: 8, height: 13.8)
        let scaledImage = image?.resized(to: desiredSize)
        view.setTitle("Русский", for: .normal)
        view.tintColor = .black
        view.setTitleColor(.darkGray, for: .normal)
        view.setImage(scaledImage, for: .normal)
        view.semanticContentAttribute = .forceRightToLeft
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        return view
    }()
    
    var switchButton: UISwitch = {
          let view = UISwitch()
          return view
      }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray5
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
           super.prepareForReuse()
           photoView.image = nil
           titleLabel.text = nil
       }
    
    func fill(_ imageName: String, title: String) {
        photoView.image = UIImage(named: imageName)
        titleLabel.text = title
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
        }
    }
}

