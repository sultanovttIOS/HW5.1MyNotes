//
//  File.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

import UIKit
import SnapKit

class SecondCustomView: UIView {
    
    private lazy var photoView = MakerView.shared.makerImageView(image: "them_icon")
    
    private lazy var titleLabel = MakerView.shared.makerLabel(text: "Темная тема", numberOfLines: 1, font: .systemFont(ofSize: 17))
    
    private lazy var mySwitch: UISwitch = {
        let view = UISwitch()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        backgroundColor = .systemGray6
        clipsToBounds = true
        addSubview(photoView)
        photoView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.width.height.equalTo(22)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(photoView.snp.trailing).offset(10)
            make.width.equalTo(111)
            make.height.equalTo(24)
        }
        addSubview(mySwitch)
        mySwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(31)
            make.width.equalTo(51)
        }
    }
}
