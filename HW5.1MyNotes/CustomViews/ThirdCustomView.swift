//
//  ThirdCustomView.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

import UIKit
import SnapKit

class ThirdCustomView: UIView {

    private lazy var deleteButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = "Очистить данные"
        configuration.image = UIImage(systemName: "trash")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 10
        let view = UIButton(configuration: configuration)
        view.tintColor = .black
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
        addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(0)
            make.height.equalTo(24)
            make.width.equalTo(200)
        }
    }
}
