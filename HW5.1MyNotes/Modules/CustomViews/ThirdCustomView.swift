//
//  ThirdCustomView.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

import UIKit
import SnapKit

class ThirdCustomView: UIView {
        
    private lazy var photoView = MakerView.shared.makerImageView(image: "delete_icon")
    
    private lazy var titleLabel = MakerView.shared.makerLabel(text: "Очистить данные", numberOfLines: 1, font: .systemFont(ofSize: 17))
    
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
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(22)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(photoView.snp.trailing).offset(10)
            make.width.equalTo(152)
            make.height.equalTo(24)
        }
    }
}
