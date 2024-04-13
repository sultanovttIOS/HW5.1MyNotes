//
//  LanguageCell.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 19/3/24.
//

import UIKit

struct FillLanguage {
    let image: String
    let language: String
}
class LanguageCell: UITableViewCell {
    static let reuseId = "language_cell"

    private lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var languageLabel: UILabel = {
        let view = UILabel()
        view.textColor = .label
        view.textAlignment = .center
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with: FillLanguage) {
        avatarImageView.image = UIImage(named: with.image)
        languageLabel.text = with.language
    }
    
    private func setupUI() {
        contentView.backgroundColor = .secondarySystemBackground
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            avatarImageView.layer.cornerRadius = 16
        }
        contentView.addSubview(languageLabel)
        languageLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.width.equalTo(89)
            make.center.equalToSuperview()
        }
    }
}
