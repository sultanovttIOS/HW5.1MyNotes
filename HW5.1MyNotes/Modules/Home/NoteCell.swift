//
//  NoteCell.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    static var reuseId = "note_cell"
    
    let colors: [UIColor] = [.red, .purple, .cyan, .green]
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 10
        backgroundColor = colors.randomElement()
        setupConstraints()
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.bottom.equalTo(-10)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    func fill(title: String) {
        titleLabel.text = title
    }
}
