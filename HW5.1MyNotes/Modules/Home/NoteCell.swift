//
//  NoteCell.swift
//  HW5.1MyNotes
//
//  Created by Alisher Sultanov on 24/2/24.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    static var reuseId = "note_cell"
                
    let colors: [UIColor] = [UIColor(named: "CustomNotesViolet")!,
                             UIColor(named: "CustomNSecondColor")!,
                             UIColor(named: "CustomNThirdColor")!,
                             UIColor(named: "CustomNFourthColor")!]
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        return view
    }()
    
    private lazy var notesTextView: UITextView = {
        let view = UITextView()
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
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(17)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    func fill(title: String) {
        titleLabel.text = title
    }
}
